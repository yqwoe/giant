class Admin::CarModelsController < ApplicationController
  before_action :set_car_model, only: [:destroy, :edit, :update]
  before_action :set_car_brand, only: [:new, :create]
  def edit
  end

  def new
    @car_model=@car_brand.car_models.build
  end

  def create
    @car_model=@car_brand.car_models.build cn_name:params[:car_model][:cn_name]
    @car_model.save!
    redirect_to edit_admin_car_brand_path(@car_model.car_brand_id)
  end

  def update
      @car_model.cn_name = params[:car_model][:cn_name]
      @car_model.save!
      redirect_to edit_admin_car_brand_path(@car_model.car_brand_id)
  end

  def destroy
    @car_model.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_car_brand
    @car_brand = CarBrand.find(params[:car_brand_id])
  end

  def set_car_model
    @car_model = CarModel.find(params[:id])
  end
end
