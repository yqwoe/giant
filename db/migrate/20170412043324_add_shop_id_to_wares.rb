class AddShopIdToWares < ActiveRecord::Migration[5.0]
  def change
    add_column :wares, :shop_id, :integer
  end
end
