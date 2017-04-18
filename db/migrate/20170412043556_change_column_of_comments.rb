class ChangeColumnOfComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :shop_id, :integer
  end
end
