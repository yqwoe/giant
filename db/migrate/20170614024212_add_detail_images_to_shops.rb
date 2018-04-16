class AddDetailImagesToShops < ActiveRecord::Migration[5.0]
  safety_assured
  def change
    add_column :shops, :detail_images, :string, array: true
  end
end
