class Admin::CarBrandsController < Admin::BaseController
  before_action :set_car_brand, only: [:edit, :update]
  def index
    @car_brands = CarBrand.all
  end

  def edit

  end

  private

  def set_car_brand
    @car_brand = CarBrand.find params[:id]
  end
end
