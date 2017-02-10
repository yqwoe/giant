class Api::V1::ViolationsController < Api::V1::BaseController
  def create
    car = current_user.cars.find_or_create_by licensed_id: params[:licensed_id]
    render json: {success: false, message: 'There is no this car.' } and return unless car

    car.vin = params[:vin]
    car.engine_no = params[:engine_no]

    car.save!

    JSON.parse(violation_params[:violations]).map do |vio|
      car.violations.create vio_date: vio[:date],
        address: vio[:address],
        penalty: vio[:penalty],
        legal: vio[:act],
        fine: vio[:fine]
    end


  end

  def index
  end

  private
    def violation_params
      params.permit(:licensed_id, :vin, :engine_no, violations: [])
    end
end
