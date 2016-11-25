class CarBrandSerializer < ActiveModel::Serializer
  attributes :cn_name, :img_url

  has_many :car_models
end
