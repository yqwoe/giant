class AddVinToCars < ActiveRecord::Migration[5.0]
  def change
    add_column :cars, :vin, :string
    add_column :cars, :engine_no, :string
  end
end
