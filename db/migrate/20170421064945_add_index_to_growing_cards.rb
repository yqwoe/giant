class AddIndexToGrowingCards < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :growing_cards, :cid, unique: true, algorithm: :concurrently
    add_index :growing_cards, :pin, unique: true, algorithm: :concurrently
  end
end
