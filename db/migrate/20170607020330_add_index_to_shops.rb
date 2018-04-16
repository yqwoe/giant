class AddIndexToShops < ActiveRecord::Migration[5.0]
  # disable_ddl_transaction!

  def change
    # add_index :shops, :deleted_at, algorithm: :concurrently
  end
end
