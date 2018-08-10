class Api::V1::OrdersController < Api::V1::BaseController
  before_action :set_car
  PARAMS = [:platform, :subject, :body, :total_amount]

  API_URL =  'https://openapi.alipay.com/gateway.do'

# setup your own credentials and certificates
  APP_ID = '2016111802958037'
  APP_PRIVATE_KEY=File.open(File.join Rails.root, 'config/key/private_key.pem').read
  ALIPAY_PUBLIC_KEY=File.open(File.join Rails.root, 'config/key/public_key.pem').read

# initialize a client to communicate with the Alipay API

  def create
    render_params_illeagal and return if params_missing?
    render_car_nil         and return unless @car

    platform     = params[:platform]
    total_amount = 880#params[:total_amount]
    subject      = params[:subject]
    body         = params[:body]
    out_trade_no = "#{platform}#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}"
    timestamp    = Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')

    @alipay_client = Alipay::Client.new(
        url: API_URL,
        app_id: APP_ID,
        app_private_key: APP_PRIVATE_KEY,
        alipay_public_key: ALIPAY_PUBLIC_KEY
    )

    order = @alipay_client.sdk_execute(
        method: 'alipay.trade.app.pay',
        biz_content: {
            out_trade_no: out_trade_no,
            total_amount: total_amount,
            subject:      subject,
            body:         body,
        }.to_json(ascii_only: true),
        format: 'json',
        timestamp: timestamp,
        notify_url: api_v1_payments_url
    )

    # order = Alipay::Mobile::Service.trade_app_pay_string(
    #   biz_content: {
    #     out_trade_no: out_trade_no,
    #     total_amount: total_amount,
    #     subject:      subject,
    #     body:         body,
    #   },
    #   timestamp: timestamp,
    #   notify_url: api_v1_payments_url
    # )
    Rails.logger.info URI.decode(order)
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
    # if params[:licensed_id].present? && params[:licensed_id].is_a?(ActionController::Parameters)
    #   params[:licensed_id] = params[:licensed_id][:licensed_id]
    # end
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
