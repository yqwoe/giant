class Api::V1::PaymentsController <  ActionController::API
  before_action :set_order, only: [:show]

  def create
    # verify
    # modify order state
    # modify car valid_at
   fp = File.open 'alipay_notifies.log', 'a'
   fp.puts params.inspect
   fp.close
    render json: { success: true }
  end

  def show
    # TODO: return !!@order.finished?
    render json: { success: true }
  end

  private

    def set_order
      @order = Order.find_by_trade_no params[:id]
    end
end
