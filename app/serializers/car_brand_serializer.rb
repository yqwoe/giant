class CarBrandSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper
  attributes :cn_name, :logo

  has_many :car_models

  def logo
    image_url("/assets/car_brand_logos/#{object.img_url}")
  end
end
