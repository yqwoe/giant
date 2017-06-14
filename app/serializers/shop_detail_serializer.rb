class ShopDetailSerializer < ShopSerializer
  attributes :image, :user_id

  def image
    object.detail_images.first if object.detail_images
  end

  def user_id

  end
end
