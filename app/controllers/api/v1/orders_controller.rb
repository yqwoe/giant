class Api::V1::OrdersController < Api::V1::BaseController
  before_action :set_car
  PARAMS = [:platform, :subject, :body, :total_amount]

  def create
    render_params_illeagal and return if params_missing?
    render_car_nil         and return unless @car

    platform     = params[:platform]
    total_amount = 880 #params[:total_amount]
    subject      = params[:subject]
    body         = params[:body]
    out_trade_no = "#{platform}#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}"
    timestamp    = Time.zone.now.strftime('%Y-%m-%d#%H:%M:%S')

    order = Alipay::Mobile::Service.trade_app_pay_string(
      biz_content: {
        total_amount: total_amount,
        subject:      subject,
        body:         body,
        out_trade_no: out_trade_no,
      },
      timestamp: timestamp,
      notify_url: api_v1_payments_url
    )
    # binding.pry
    # create order
    @car.orders.create(
      body:         body,
      subject:      subject,
      status:       :created,
      platform:     platform,
      trade_no:     out_trade_no,
      total_amount: total_amount
    )
    render json: { success: true, order_string: order }
  end

  def notify
   fp = File.open 'alipay_notifies.log', 'a'
   fp.puts params.inspect
   fp.close
   # order = Order.find_by trade_no

   # if Alipay::App::Service.verify? params
   #   car = order.car
   #   car.valid_at = Time.zone.now + 1.year
   #   order.success!
   # else
   #   order.failed!
   # end
  end

  private

  def set_car
    @car = current_user.cars
      .find_by licensed_id: params[:licensed_id]&.upcase
  end

  def render_car_nil
    render json: {success: false, message: '请先添加车辆！'}
  end

  def render_params_illeagal
    render json: {success: false, message: '非法参数'}
  end

  def params_missing?
    result = false
    PARAMS.each do |param|
      result ||= params[param].blank?
    end

    result
  end
end
