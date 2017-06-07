class AddDeletedAtToShops < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :deleted_at, :datetime
  end
end
