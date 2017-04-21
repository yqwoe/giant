class AddIndexToGrowingUsers < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :growing_users, :mobile, unique: true, algorithm: :concurrently
  end
end
