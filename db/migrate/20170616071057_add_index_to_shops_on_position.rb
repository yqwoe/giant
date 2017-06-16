class AddIndexToShopsOnPosition < ActiveRecord::Migration[5.0]
  def change
    add_earthdistance_index :shops, lat: 'cast(position[1] as real)', lng: 'cast(position[2] as real)'
  end
end
