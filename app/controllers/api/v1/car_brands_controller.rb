class Api::V1::CarBrandsController < ApplicationController
  def index
    data = []

    ('A'..'Z').to_a.each do |initial_letter|
      brands = []
      CarBrand.send(initial_letter).find_each do |brand|
        car = {}
        car[:icon] = view_context.image_url("car_logos/#{brand.img_url}")
        car[:name] = brand[:cn_name]
        brands << car
      end
      data << { cars: brands, title: initial_letter }

    end

    render json: { data: data }
  end

  def show
    render json: CarBrand.find(params[:id])
  end
end
