class AddIndexToUsers < ActiveRecord::Migration[5.0]
  safety_assured
  def change
    add_index :users, :mobile, unique: true
  end
end
