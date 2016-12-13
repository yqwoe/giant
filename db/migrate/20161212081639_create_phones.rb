class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.string :phone
      t.string :pin
      t.boolean :verified

      t.timestamps
    end
  end
end
