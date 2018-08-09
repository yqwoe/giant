class AddIndexToCars < ActiveRecord::Migration[5.0]
  def change
    safety_assured { add_index :cars, :licensed_id, unique: true }
  end
end
