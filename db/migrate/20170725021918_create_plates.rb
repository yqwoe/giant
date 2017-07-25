class CreatePlates < ActiveRecord::Migration[5.1]
  def change
    create_table :plates do |t|
      t.string :licensed_id
      t.string :avatar

      t.timestamps
    end
  end
end
