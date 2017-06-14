class ShopDetailSerializer < ShopSerializer
  attributes :image

  def image
    object.detail_images.first if object.detail_images
  end
end
