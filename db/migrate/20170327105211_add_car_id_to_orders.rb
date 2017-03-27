class AddCarIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :car_id, :integer
    remove_column :orders, :user_id, :integer
  end
end
