class AddIndexToCards < ActiveRecord::Migration[5.0]
  add_index :cards, :id
  add_index :cards, :cid
end
