class Api::V1::CarBrandsController < ApplicationController
  def index
    data = []

    ('A'..'Z').to_a.each do |initial_letter|
      brands = []
      CarBrand.send(initial_letter).find_each do |brand|
        car = {}
        car[:icon] = view_context.image_url("car_logos/#{brand.img_url}")
        car[:name] = brand[:cn_name]
        car[:id]   = brand[:id]
        brands << car
      end
      data << { cars: brands, title: initial_letter }

    end

    render json: { data: data }
  end

  def show
    brand = CarBrand.find(params[:id])
    models = brand.car_models.pluck(:cn_name)

    render plain: models
  end
end
