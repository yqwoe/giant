class CreateSuites < ActiveRecord::Migration[5.0]
  def change
    create_table :suites do |t|
      t.string :name
      t.float :origin_price
      t.float :sale_price
      t.integer :store

      t.timestamps
    end
  end
end
