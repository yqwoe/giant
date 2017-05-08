class ChangeTradeNoOfSuiteOrders < ActiveRecord::Migration[5.0]
  def change
    remove_column :suite_orders, :trade_no, :integer
    add_column    :suite_orders, :trade_no, :string
  end
end
