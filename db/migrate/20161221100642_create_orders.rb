class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :state
      t.integer :payment_gateway
      t.integer :trade_no
      t.float :price
      t.integer :quantity
      t.float :distcount
      t.string :subject

      t.timestamps
    end
  end
end
