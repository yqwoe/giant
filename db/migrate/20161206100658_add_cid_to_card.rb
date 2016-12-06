class AddCidToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :cid, :integer
  end
end
