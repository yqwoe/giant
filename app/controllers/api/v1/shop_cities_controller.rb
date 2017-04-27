class Api::V1::ShopCitiesController < ApplicationController
  def index
    render json: ShopCity.all
  end
end
