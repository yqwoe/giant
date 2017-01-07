class Api::V1::PaymentsController < ApplicationController
  before_action :set_order

  def create
    # verify
    # modify order state
    # modify car valid_at
    render json: { success: true }
  end

  def show
    
  end

  private

    def set_order
      @order = Order.find_by_trade_no params[:out_trade_no]
    end
end
