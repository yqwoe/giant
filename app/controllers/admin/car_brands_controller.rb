class Admin::CarBrandsController < Admin::BaseController
  def index
    @car_brands = CarBrand.page(params[:page])
  end
end
