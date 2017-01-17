class AddDefaultImageToShops < ActiveRecord::Migration[5.0]
  safety_assured if Rails.env.development?

  IMG_URL = 'default_shop.png'

  def change
    change_column_default :shops, :image, IMG_URL

    Shop.update_all(image: IMG_URL)
  end
end
