class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards, id: false do |t|
      t.integer :id
      t.string :pin

      t.timestamps
    end
  end
end
