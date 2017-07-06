class Api::V1::CarsController < Api::V1::BaseController
  before_action :set_car, only: [:wash]
  before_action :set_shop, only: [:wash]

  TEST_USERS = %w(13652885999
                  13673669302
                  15838208401
                  18639970824
                  15518873587
                  15010971864
                  17710052758
                  15225140834
  )

  def create
    if car = Car.find_by(licensed_id: params[:licensed_id])
      render json: {
        success: false,
        message: "车牌已经与#{car.user.mobile}绑定",
      } and return
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
    if current_user.cars.count > 0
      render json: current_user.cars
    else
      render json: { success: false, message: '该用户没有绑定任何车辆！' }
    end
  end

  def wash
    render_car_not_exist    and return unless @car
    render_shop_not_exist_or_pending and return unless @shop && @shop.actived?

    @car.user.reset_member
    render_not_member       and return unless @car.user&.member?
    render_not_in_service   and return unless car_in_service?
    # render_qrcode_not_valid and return unless verify_qrcode?
    # render_question_wash    and return if too_often?
    if find_or_create_wash_record
      push_to_shop_owner
      render_success_washed
    else
      render_deals_create_error
    end
  rescue => @error
    render_notify_error
  end

  private

    def push_to_shop_owner
      message = {
        platform: 'all',
        audience: @shop.user.mobile,
        body: "#{@car.licensed_id}验证成功！",
      }

      JpushService.shop message
    end

    def set_shop
      @shop = Shop.where(id: params[:shop_id]).take
    end

    def too_often?
      return false if TEST_USERS.include? current_user.mobile
      @car.deals.last30d.by_shop(@shop).select(:id).count >= 8
    end

    def find_or_create_wash_record
      @deal = Deal.new
      @deal.car_id = @car.id
      @deal.user_id = current_user.id
      @deal.shop_id = @shop.id
      @deal.cleaned_at = Time.zone.now
      #TODO: enable avatar for deal
      # @deal.avatar = params[:avatar]

      @deal.save
    end

    def render_faild_multi_wash
      render_deals_create_error
    end

    def render_already_recorded
      render_success_washed
    end

    def render_deals_create_error
      render json: {
        code:   -1,
        info:   '系统异常！',
        success: false,
        message: @deal.errors.messages,
        error:   @deal.errors.messages
      }
    end

    def render_notify_error
      render json: {
        code:   -1,
        info:   '通知车行失败',
        success: false,
        message: @error.message
      }
    end

    def render_success_washed
      render json: {
        code:        0,
        info:        '验证成功！',
        success:      @car.user.member?,
        message:      '成功创建洗车记录'
        # car_brand:   @car&.car_model&.car_brand&.cn_name,
        # car_model:   @car&.car_model&.cn_name,
        # valid_date:  @car.valid_at,
        # licensed_id: @car.licensed_id,
        # authenticated_at: Time.zone.now.strftime('%Y-%m-%d %H:%M')
      }
    end


    def render_shop_not_exist_or_pending
      render json: {
        code:    -1,
        info:    '车行账户异常',
        success: false,
        # member: false,
        message: '账户已停用或暂未启用'
      }
    end

    def render_question_wash
      render json: {
        code:    -1,
        info:    '账户异常',
        success: false,
        # member:  false,
        message: '账户异常，请去其他车行尝试洗车。'
      }
    end

    def car_in_service?
      # FIXME: to limit deals less than 1
      !!@car.valid_at && @car.valid_at >= Time.zone.now.beginning_of_day
    end

    def render_qrcode_not_valid
      if deal_params[:did].present?
        render json: {success: false,
                      message: '二维码超时，请车主重新进入二维码界面后再次进行认证',
                      member: false}
      else
        render json: {success: false,
                      message: '请提醒车主升级APP后重试。',
                      member: false}
      end
    end

    def render_not_member
      render json: {
        code:    -1,
        info:    '非会员用户',
        success: false,
        message: '您的车辆不是会员',
        member: false}
    end

    def render_car_not_exist
      render json: {
        code:    -2,
        info:    '车辆不存在',
        success: false,
        message: '您的账户没有该车辆!',
        member:  false }
    end

    def render_not_in_service
      render json: {
        code:    -1,
        info:    '非会员用户',
        success: false,
        message: '该车不在服务范围之内',
        member: false }
    end

    def verify_qrcode?
      return false unless deal_params[:h]
      deal_params[:h] == $redis.get(deal_params[:did])
    end

    def set_car
      licensed_id = params[:licensed_id]
      @car = current_user.cars.find_by_licensed_id licensed_id
    end

    def deal_params
      Rack::Utils.parse_nested_query(params[:qrcode_info]).with_indifferent_access
    end

    def last_3days_deals_count
      Deal.last3d.where('car_id = ?', @car.id).count if @car
    end
end
