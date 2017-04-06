class RemoveIndexFromDevices < ActiveRecord::Migration[5.0]
  def change
    remove_index :devices, [:uuid, :user_id]
    remove_column :devices, :user_id, :integer
  end
end
