class AddGrowingUserIdToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :growing_user_id, :integer
  end
end
