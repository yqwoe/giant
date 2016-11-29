class AddInitialLetterToCarBrands < ActiveRecord::Migration[5.0]
  def change
    add_column :car_brands, :initial_letter, :string
  end
end
