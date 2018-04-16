class AddIndexToCars < ActiveRecord::Migration[5.0]
  safety_assured
  def change
    add_index :cars, :licensed_id, unique: true
  end
end
