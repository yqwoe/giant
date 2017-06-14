class ShopDetailSerializer < ShopSerializer
  def img_url
    object.detail_images.first if object.detail_images
  end
end
