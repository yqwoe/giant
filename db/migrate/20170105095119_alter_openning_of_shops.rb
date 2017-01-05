class AlterOpenningOfShops < ActiveRecord::Migration[5.0]
  def change
    remove_column :shops, :openning, :daterange
    add_column :shops, :openning, :string
  end
end
