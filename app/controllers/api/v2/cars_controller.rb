class Api::V2::CarsController < Api::V1::BaseController
  before_action :set_car,  only: [:wash]
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

  def fuzz
    render json: @car&.licensed_id
  end

  def wash
    #render_car_not_exist             and return unless @car
    @car.user.reset_member

    #
    # 先验证单次洗车
    #
    user = @car.user
    account = user.account
    if account && account.valid_to >= Time.zone.now
      deal_count = user.deals.this_month.count
      if deal_count > 0
        render_faild_multi_wash and return
      else
        find_or_create_wash_record
        render_success_washed and return
      end
    end

    unless @shop && @shop.actived?
      render_shop_not_exist_or_pending and return
    end

    render_not_member       and return unless @car.user&.member?
    render_not_in_service   and return unless car_in_service?
    render_question_wash    and return if     too_often?
    render_qrcode_not_valid and return unless verify_qrcode?

    if @car.deals.last4h.count > 0
      render_already_recorded and return
    end

    if find_or_create_wash_record
      render_success_washed
    else
      render_deals_create_error
    end
  rescue => @error
    render_notify_error
  end

  private

    def set_shop
      return @shop unless current_user.shop_owner?

      @shop = current_user.shops.first
    end

    def too_often?
      return false if TEST_USERS.include? current_user.mobile

      current_month_wash_count >= 6
    end

    def current_month_wash_count
      @car.deals.this_month.by_shop(@shop).select(:id).count
    end

    def find_or_create_wash_record
      # make sure user upload picture
      # return false unless params[:avatar].present?

      @deal = Deal.new
      @deal.car_id  = @car.id
      @deal.shop_id = @shop.id
      @deal.cleaned_at = Time.zone.now
      @deal.avatar = params[:avatar]

      @deal.save
    end

    def render_faild_multi_wash
      render_deals_create_error
    end

    def render_already_recorded
      render json: {
        code:             1,
        info:             '验证成功！',
        success:          @car.user.member?,
        message:          '车行记录已添加，请勿重复验证',
        car_brand:        @car&.car_model&.car_brand&.cn_name,
        car_model:        @car&.car_model&.cn_name,
        valid_date:       @car.valid_at,
        licensed_id:      @car.licensed_id,
        authenticated_at: @car.deals.last.created_at.strftime('%Y-%m-%d %H:%M')
      }
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
        code:   0,
        info:   '验证成功',
        success: false,
        message: '验证失败，您还未激活，请在“在线激活”页面激活  '
      }
    end

    def render_success_washed
      render json: {
        code:             0,
        info:             '验证成功！',
        success:          @car.user.member?,
        message:          '成功创建洗车记录',
        car_brand:        @car&.car_model&.car_brand&.cn_name,
        car_model:        @car&.car_model&.cn_name,
        valid_date:       @car.valid_at,
        licensed_id:      @car.licensed_id,
        authenticated_at: Time.zone.now.strftime('%Y-%m-%d %H:%M')
      }
    end

    def render_shop_not_exist_or_pending
      render json: {
        code:    -1,
        info:    '车行账户异常',
        success: false,
        # member: false,
        message: '车行已下线或暂停合作'
      }
    end

    def render_question_wash
      render json: {
        code:    -1,
        info:    '验证失败',
        success: false,
        # member:  false,
        message: "本月在#{@shop.name}洗车已超过8次，请更换别家车行。\n" +
                 "欢迎下月再光顾"
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
        message: '用户为非会员激活车辆',
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
      @car = Car.find_by_licensed_id deal_params[:l]
    end

    def deal_params
      Rack::Utils.parse_nested_query(params[:qrcode_info]).with_indifferent_access
    end

    def last_3days_deals_count
      Deal.last3d.where('car_id = ?', @car.id).count if @car
    end
end
