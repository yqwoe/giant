class AddStatusToShopCities < ActiveRecord::Migration[5.0]
  def change
    add_column :shop_cities, :status, :integer
  end
end
