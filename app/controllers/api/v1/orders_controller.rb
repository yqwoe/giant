class Api::V1::OrdersController < Api::V1::BaseController
  def create
    platform = params[:platform]
    total_amount = params[:total_amount]
    subject = params[:subject]
    body = params[:body]
    car = current_user.cars.find_by licensed_id: params[:licensed_id]&.upcase
    render json: {success: false, message: '请先添加车辆！'} and return unless car

    out_trade_no = "#{platform}#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}"
    timestamp = Time.zone.now.strftime('%Y-%m-%d#%H:%M:%S')

    order =  Alipay::Mobile::Service.trade_app_pay_string(
      biz_content: {
        total_amount: total_amount,
        subject:      subject,
        body:         body,
        out_trade_no: out_trade_no,
      },
      timestamp: timestamp,
      notify_url: api_v1_payments_url
    )

    # create order
    car.orders.create(platform: platform,
                 total_amount: total_amount,
                 subject: subject,
                 body: body,
                 trade_no: out_trade_no,
                 status: :created
                )
    render json: { order_string: order }
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
end
