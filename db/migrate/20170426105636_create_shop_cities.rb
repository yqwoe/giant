class CreateShopCities < ActiveRecord::Migration[5.0]
  def change
    create_table :shop_cities do |t|
      t.string :province
      t.string :city
      t.float :center

      t.timestamps
    end
  end
end
