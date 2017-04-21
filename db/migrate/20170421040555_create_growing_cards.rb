class CreateGrowingCards < ActiveRecord::Migration[5.0]
  def change
    create_table :growing_cards do |t|
      t.string :cid
      t.string :pin
      t.float :range

      t.timestamps
    end
    add_index :growing_cards, :cid, unique: true
    add_index :growing_cards, :pin, unique: true
  end
end
