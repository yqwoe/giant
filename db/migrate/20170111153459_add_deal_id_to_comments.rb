class AddDealIdToComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :user_id, :integer
    remove_column :comments, :shop_id, :integer
    add_column :comments, :deal_id, :integer
  end
end
