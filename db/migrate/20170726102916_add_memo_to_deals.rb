class AddMemoToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :memo, :string
  end
end
