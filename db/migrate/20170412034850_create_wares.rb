class CreateWares < ActiveRecord::Migration[5.0]
  def change
    create_table :wares do |t|
      t.string :name
      t.float :origin_price
      t.float :sale_price
      t.string :avatar
      t.string :tags

      t.timestamps
    end
  end
end
