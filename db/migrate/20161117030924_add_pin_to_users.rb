class AddPinToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pin, :string
    add_column :users, :verified, :boolean
  end
end
