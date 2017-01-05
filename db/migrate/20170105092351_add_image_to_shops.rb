class AddImageToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :image, :string
  end
end
