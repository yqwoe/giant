class AddIndexToShops < ActiveRecord::Migration
  disable_ddl_transaction!

  def change
    add_index :shops, :deleted_at, algorithm: :concurrently
  end
end
