class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :deposit_by_times
      t.decimal :deposit_cash
      t.decimal :available_cash

      t.timestamps
    end
  end
end
