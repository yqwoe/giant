class CouponSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper
  attributes :id, :image, :status

  def image
    image_url("/assets/coupons/#{object.avatar}")
  end
end
