class AddTimesToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :card_times, :integer
  end
end
