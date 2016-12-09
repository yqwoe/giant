class Api::V1::CarsController < Api::V1::BaseController
  def create
    car_model = CarBrand.find(params[:car_brand_id]).car_models.find_by_cn_name(params[:car_model])
    render json: {success: false, message: 'Invalid car model'} unless car_model

    current_user.cars.build(car_model_id: car_model.id,
                      licensed_id: params[:licensed_id])

    if current_user.save!
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
