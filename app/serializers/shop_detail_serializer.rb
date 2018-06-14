class ShopDetailSerializer < ShopSerializer
  attributes :image, :user_id

  def image
    img_url
  end

  def user_id

  end
end
