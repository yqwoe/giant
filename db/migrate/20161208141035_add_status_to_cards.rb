class AddStatusToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :status, :integer, default: 0
  end
end
