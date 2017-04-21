class AddStatusToGrowingUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :growing_users, :status, :integer
  end
end
