class AlterCommentsOfDeals < ActiveRecord::Migration[5.0]
  def change
    remove_column :deals, :comments, :string
    add_column :deals, :comment_id, :integer
  end
end
