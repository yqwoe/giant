class AddShopIdToSuites < ActiveRecord::Migration[5.0]
  def change
    remove_column :wares, :shop_id, :integer
    add_column :suites, :shop_id, :integer
  end
end
