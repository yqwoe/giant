class Api::V1::ShopsController < ApplicationController
  def index
    @q = Shop.ransack(params[:q])
    @shops = @q.result(distinct: true).as_json
    render json: @shops
  end

  def show
    @shop = Shop.find(params[:id])
    render json: @shop
  end
end
