class ShopSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper

  attributes :id, :name, :phone, :city, :star, :category, :address, :duration,
    :status, :profile, :services, :sale_content, :province, :county, :position,
    :img_url, :openning


  def img_url
    image_url("/assets/#{object.image}")
  end
end
