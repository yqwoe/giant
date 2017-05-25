class AddDefaultStatusToShops < ActiveRecord::Migration[5.0]
  def change
    change_column_default :shops, :status, 1
  end
end
