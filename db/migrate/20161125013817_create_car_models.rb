class CreateCarModels < ActiveRecord::Migration[5.0]
  def change
    create_table :car_models do |t|
      t.integer :car_brand_id
      t.string :cn_name
      t.string :en_name
      t.string :initial_letter

      t.timestamps
    end
  end
end
