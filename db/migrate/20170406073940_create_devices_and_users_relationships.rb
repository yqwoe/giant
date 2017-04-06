class CreateDevicesAndUsersRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :devices_and_users_relationships do |t|
      t.integer :device_id
      t.integer :user_id

      t.timestamps
    end
  end
end
