class Api::V1::CarsController < Api::V1::BaseController
  before_action :set_car, only: [:wash]

  TEST_USERS = %w(13652885999 136736693021 15838208401 18639970824)

  def create
    if current_user.cars.find_by(licensed_id: params[:licensed_id].upcase)
      render json: { success: false, message: '该车牌已经被绑定' } and return
    end

    car_model = CarBrand.find(params[:car_brand_id]).car_models.find_by_cn_name(params[:car_model])
    render json: {success: false, message: '无效车型'} and return unless car_model

    car = current_user.cars.build(car_model_id: car_model.id,
                            licensed_id: params[:licensed_id].upcase)

    if TEST_USERS.include? current_user.mobile
      car.valid_at = 1.year.from_now
    end

    if current_user.save!
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

  def index
    response.set_header("Access-Control-Allow-Origin", "*")
    if current_user.cars.count>0
      render json: current_user.cars
    else
      render json: { success: false, message: '该用户没有绑定任何车辆！' }
    end
  end

  def wash
    render_car_not_exist    and return unless @car
    render_not_member       and return unless @car.user&.member?
    render_not_in_service   and return unless car_in_service?
    # Fixme: will use this by market
    # render_qrcode_not_valid and return unless verify_qrcode?
    find_or_create_wash_record
  end

  private
    def find_or_create_wash_record
      #TODO: think about multi shops

      shop = current_user.shops.first
      deal = @car.deals.today.first
      if deal
        if deal.find_by_shop_id(shop)&.first
          # 假如是同一家店铺，则直接返回验证成功
          render_success_washed and return
        else
          # 假如不是同一家店铺，则验证不通过
          render_faild_multi_wash and return
        end
      end

      deal = @car.deals.build
      deal.user_id = current_user.id
      deal.shop_id = current_user.shops.first.id
      deal.cleaned_at = Time.zone.now

      if @car.save
        render_success_washed
      else
        render_deals_create_error
      end
    end

    def render_faild_multi_wash
      render_deals_create_error
    end

    def render_already_recorded
      render_success_washed
    end

    def render_deals_create_error
      render json: {
        member: false,
        success: false,
        message: '创建洗车记录失败'
      }
    end

    def render_success_washed
      render json: {
        member:      @car.user.member?,
        car_brand:   @car&.car_model&.car_brand&.cn_name,
        car_model:   @car&.car_model&.cn_name,
        valid_date:  @car.valid_at,
        licensed_id: @car.licensed_id
      }
    end

    def car_in_service?
      # FIXME: to limit deals less than 1
      !!@car.valid_at && @car.valid_at >= Time.zone.now
    end

    def render_qrcode_not_valid
        render json: {success: false, message: '数据异常', member: false}
    end

    def render_not_member
      render json: {success: false, message: '非会员车辆', member: false}
    end

    def render_car_not_exist
      render json: { success: false, message: '该辆车不存在!', member: false }
    end

    def render_not_in_service
      render json: { success: false, message: '该车不在服务范围之内', member: false }
    end

    def verify_qrcode?
      return false if last_3days_deals_count >= 2
      return true  if deal_params[:h] == $redis.get(deal_params[:did])
      return false
    end

    def set_car
      licensed_id = deal_params[:l] || params[:licensed_id]
      @car = Car.find_by_licensed_id licensed_id
    end

    def deal_params
      Rack::Utils.parse_nested_query(params[:qrcode_info]).with_indifferent_access
    end

    def last_3days_deals_count
      Deal.last3d.where('car_id = ?', @car.id).count if @car
    end
end
