class CarSerializer < ActiveModel::Serializer
  attributes :licensed_id, :joined_at, :valid_at, :visited_at, :city, :car_brand_url

  def car_brand_url
    CarBrandSerializer.new(object.car_model.car_brand)
  end
end
