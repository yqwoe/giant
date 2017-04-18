class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.integer :seller_id
      t.integer :second_seller_id
      t.integer :custom_id
      t.float :commission_portion, default: 0
      t.float :second_commission_portion, default: 0

      t.timestamps
    end
  end
end
