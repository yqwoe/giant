class AddValidAtToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :valid_at, :date
  end
end
