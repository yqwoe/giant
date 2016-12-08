class Api::V1::DealsController < ApplicationController
  def index
    current_user.deals.order_by(id: desc)
  end

  def show
    current_user.deals.find params[:id]
  end
end
