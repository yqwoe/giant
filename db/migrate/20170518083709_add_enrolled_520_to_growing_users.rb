class AddEnrolled520ToGrowingUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :growing_users, :enrolled_520, :boolean
  end
end
