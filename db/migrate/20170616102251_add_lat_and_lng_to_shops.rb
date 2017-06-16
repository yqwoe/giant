class AddLatAndLngToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :lat, :float
    add_column :shops, :lng, :float
  end
end
