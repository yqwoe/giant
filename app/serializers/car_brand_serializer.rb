class CarBrandSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper

  attributes :cn_name, :logo

  has_many :car_models

  def logo
    img_url = object.img_url ?  object.img_url : 'default.png'
    image_url("/assets/car_brand_logos/#{img_url}")
  end
end
