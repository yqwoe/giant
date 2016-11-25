class CreateCarBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :car_brands do |t|
      t.string :en_name
      t.string :cn_name
      t.string :shor_name
      t.string :img_url
      t.string :manufacture

      t.timestamps
    end
  end
end
