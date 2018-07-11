class ShopSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper
  IMG_HOST = 'https://api.autoxss.com/shops/images/'.freeze

  attributes :id, :name, :phone, :city, :star, :category, :address, :duration,
    :status, :profile, :services, :sale_content, :province, :county, :position,
    :img_url, :openning


  def img_url
    image_path("#{IMG_HOST}#{object.image}")
  end
end
