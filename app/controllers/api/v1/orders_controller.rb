class Api::V1::OrdersController < Api::V1::BaseController
  def create
    platform = params[:platform]
    total_amount = params[:total_amount]
    subject = params[:subject]
    body = params[:body]
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
    Order.create(platform: platform,
                 subject: subject,
                 body: body,
                 trade_no: out_trade_no,
                 status: 0
                )
    render json: { order_string: order }
  end
end
