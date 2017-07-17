class AddShortNameToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :short_name, :string
  end
end
