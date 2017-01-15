class RemoveCards < ActiveRecord::Migration[5.0]
  def up
    drop_table :cards
  end
end
