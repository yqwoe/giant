class CreateGrowingCards < ActiveRecord::Migration[5.0]
  def change
    create_table :growing_cards do |t|
      t.string :cid
      t.string :pin
      t.float :range

      t.timestamps
    end
  end
end
