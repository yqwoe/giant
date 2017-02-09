class AddCarIdToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :car_id, :integer
  end
end
