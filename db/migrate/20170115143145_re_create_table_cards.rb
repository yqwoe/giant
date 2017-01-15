class ReCreateTableCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :cid
      t.string :pin
    end
  end
end
