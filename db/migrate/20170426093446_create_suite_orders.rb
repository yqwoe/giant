class CreateSuiteOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :suite_orders do |t|
      t.integer :user_id
      t.integer :state
      t.integer :payment_gateway
      t.integer :trade_no
      t.float   :price
      t.integer :quantity
      t.belongs_to :suite
      t.belongs_to :coupon
      t.integer :platform

      t.timestamps
    end
  end
end
