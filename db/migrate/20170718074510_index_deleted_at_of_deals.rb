class IndexDeletedAtOfDeals < ActiveRecord::Migration[5.1]
  disable_ddl_transaction!

  def change
    add_index :deals, :deleted_at, algorithm: :concurrently
  end
end
