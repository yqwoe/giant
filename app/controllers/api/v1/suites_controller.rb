class Api::V1::SuitesController < Api::V1::BaseController
  def create
    platform =      params[:platform]
    @total_amount = params[:total_amount].to_f
    @suite =        Suite.find params[:suite_id]
    render_suite_not_exist    and return unless @suite

    if params[:coupon_id].present?
      @coupon =       Coupon.find params[:coupon_id]
      render_coupon_not_exist   and return unless @coupon
      render_total_amount_error and return unless is_correct_total_amount?
    end

    out_trade_no = "#{platform}#{Time.zone.now.strftime('%Y%m%d%H%M%S%L')}"
    timestamp    = Time.zone.now.strftime('%Y-%m-%d#%H:%M:%S')

    order_string =  Alipay::Mobile::Service.trade_app_pay_string(
      biz_content: {
        total_amount: @total_amount,
        subject:      @suite.name,
        out_trade_no: out_trade_no,
      },
      timestamp:  timestamp,
      notify_url: api_v1_payments_url
    )

    # create order
    current_user.suite_orders.create(
      platform:        platform,
      price:           @total_amount,
      trade_no:        out_trade_no,
      state:           :created,
      payment_gateway: :alipay,
      suite_id:        @suite.id,
      coupon_id:       @coupon&.id
    )
    render json: { success: true, order_string: order_string }

  end

  def show
    render json: {
      success: true,
      suite_order: SuiteOrderSerializer.new(@suite_order)
    }
  end

  private

  def is_correct_total_amount?
    (@suite.sale_price - @coupon.deductible) == @total_amount
  end

  def render_total_amount_error
    render json: { success: false, message: "总金额不匹配！" }
  end

  def render_suite_not_exist
    render json: { success: false, message: "该套餐不存在！" }
  end

  def render_coupon_not_exist
    render json: { success: false, message: "该优惠券不存在!" }
  end
end
