class Api::V1::CarsController < Api::V1::BaseController
  def create
    current_user.cars.build(car_model_id: car_model_id,
                      licensed_id: params[:licensed_id])

    if @user.save!
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
