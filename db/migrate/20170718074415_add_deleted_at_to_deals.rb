class AddDeletedAtToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :deleted_at, :datetime
  end
end
