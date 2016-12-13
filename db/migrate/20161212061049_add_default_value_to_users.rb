class AddDefaultValueToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :roles, 0
  end
end
