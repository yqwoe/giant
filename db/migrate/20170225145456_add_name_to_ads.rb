class AddNameToAds < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :name, :string
  end
end
