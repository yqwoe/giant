class Admin::CarsController < Admin::BaseController
  before_action :set_car, only: [:show, :update, :destroy]

  def update
    @car.licensed_id = car_params[:licensed_id]
    @car.valid_at = car_params[:valid_at]
    @car.save
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def destroy
    if @car.delete
      respond_to do |format|
        format.js
      end
    else
      render json: {success: false, message: @car.errors.message}
    end
  end

  private

  def set_car
    @car = Car.find params[:id]
  end

  def car_params
    params.fetch(:car, {})
  end
end
