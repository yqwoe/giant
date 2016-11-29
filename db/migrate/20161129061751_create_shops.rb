class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :phone
      t.string :city
      t.integer :star
      t.string :category
      t.string :address
      t.daterange :duration
      t.daterange :openning
      t.integer :status
      t.string :profile
      t.integer :star
      t.string :category
      t.string :services
      t.string :sale_content
      t.string :province
      t.string :city
      t.string :county
      t.string :address
      t.string :position, array: true

      t.timestamps
    end
  end
end
