class AddIndexToDevicesAndUsersRelationships < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!
  def change
    add_index :devices_and_users_relationships, [:device_id, :user_id],
      unique: true, algorithm: :concurrently
  end
end
