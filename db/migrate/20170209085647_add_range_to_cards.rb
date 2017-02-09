class AddRangeToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :range, :integer
  end
end
