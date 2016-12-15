class CarSerializer < ActiveModel::Serializer
  attributes :licensed_id, :car_brand_url

  def car_brand_url
    CarBrandSerializer.new(object.car_model.car_brand)
  end
end
