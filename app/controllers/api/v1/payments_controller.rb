class Api::V1::PaymentsController < Api::V1::BaseController
  before_action :set_order, only: [:show]

  def create
    # verify
    # modify order state
    # modify car valid_at
    render json: { success: true }
  end

  def show
    render json: { success: !!@order&.finished? }
  end

  private

    def set_order
      @order = Order.find_by_trade_no params[:id]
    end
end
