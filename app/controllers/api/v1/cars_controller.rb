class Api::V1::CarsController < ApplicationController
  def index
    render json: CarBrand.all
  end

  def show
    render json: CarBrand.find(params[:id])
  end
end
