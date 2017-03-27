class Api::V1::OrdersController < Api::V1::BaseController
  def create
    platform = params[:platform]
    total_amount = params[:total_amount]
    subject = params[:subject]
    body = params[:body]
    car = current_user.cars.find_by licensed_id: params[:licensed_id].upcase
    render json: {success: false, message: '请先添加车辆！'} and return unless car

    out_trade_no = "#{platform}#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}"
    timestamp = Time.zone.now.strftime('%Y-%m-%d#%H:%M:%S')

    order =  Alipay::App::Service.alipay_trade_app_pay(
      biz_content: {
        total_amount: total_amount,
        subject:      subject,
        body:         body,
        out_trade_no: out_trade_no,
      },
      timestamp: timestamp,
      notify_url: notify_api_v1_orders_url
    )

    # create order
    car.orders.create(platform: platform,
                 subject: subject,
                 body: body,
                 trade_no: out_trade_no,
                 status: :created
                )
    render json: { order_string: order }
  end

  def notify
    order = Order.find_by trade_no

    if Alipay::App::Service.verify? params
      car = order.car
      car.valid_at = Time.zone.now + 1.year
      order.success!
    else
      order.failed!
    end
  end
end
