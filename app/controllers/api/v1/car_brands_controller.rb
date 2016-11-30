class Api::V1::CarBrandsController < ApplicationController
  def index
    data = []

    ('A'..'Z').to_a.each do |initial_letter|
      brands = []
      CarBrand.send(initial_letter).includes(:car_models).find_each do |brand|
        car = {}
        car[:icon] = view_context.image_url("car_logos/#{brand.img_url}")
        car[:name] = brand[:cn_name]
        car[:id]   = brand[:id]
        car[:car_models] =  brand.car_models.pluck(:cn_name)
        brands << car
      end

      data << { cars: brands, title: initial_letter }

    end

    render json: { data: data }
  end

  def show
    brand = CarBrand.includes(:car_models).find(params[:id])
    models = brand.car_models.pluck(:cn_name)

    render json: {car_models: models}
  end
end
