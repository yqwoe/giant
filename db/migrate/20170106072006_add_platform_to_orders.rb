class AddPlatformToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :platform, :integer
    add_column :orders, :total_amount, :float
    add_column :orders, :body, :string
    add_column :orders, :finished_at, :datetime
    add_column :orders, :canceled_at, :datetime
  end
end
