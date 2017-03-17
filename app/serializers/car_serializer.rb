class CarSerializer < ActiveModel::Serializer
  attributes :licensed_id, :car_model, :joined_at, :valid_at, :visited_at,
    :city, :car_brand_url

  def car_brand_url
    return nil unless object.car_model
    if object.car_model.car_brand
      object.car_model ? CarBrandSerializer.new(object.car_model.car_brand) : nil
    end
  end

  def car_model
    object.car_model ? CarModelSerializer.new(object.car_model) : nil
  end
end
