class AddDateToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :created_at, :datetime
    add_column :cards, :updated_at, :datetime
    add_column :cards, :actived_at, :datetime
  end
end
