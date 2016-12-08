class Api::V1::ShopsController < ApplicationController
  def index
    @q = Shops.ransack(params[:q])
    @shops = @q.result(distinct: true).as_json
  end

  def show
    Shops.find(params[:id]).as_json
  end
end
