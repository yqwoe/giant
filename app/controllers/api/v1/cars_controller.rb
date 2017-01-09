class Api::V1::CarsController < Api::V1::BaseController
  def create
    if current_user.cars.find_by(licensed_id: params[:licensed_id])
      render json: { success: false, message: '该车牌已经被绑定' }
    end
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

  def index
    if current_user.cars
      render json: current_user.cars
    else
      render json: { success: false, message: '该用户没有绑定任何车辆！' }
    end
  end

  def wash
    car = Car.find_by_licensed_id(params[:licensed_id])
    render json: { car_brand: car&.car_model&.car_brand&.cn_name,
                   car_model: car&.car_model&.cn_name,
                   licensed_id: car.licensed_id,
                   valid_date: car.valid_at,
                   member: !!(car.valid_at > Time.now)
    }
  end
end
