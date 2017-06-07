class ChangeTradeNoTypeOfOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :trade_no, :integer
    add_column    :orders, :trade_no, :string
  end
end
