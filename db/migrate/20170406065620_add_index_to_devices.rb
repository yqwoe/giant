class AddIndexToDevices < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :devices, [:uuid, :user_id], algorithm: :concurrently
  end
end
