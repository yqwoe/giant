class ChangeVersionsColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :versions, :type, :integer
    add_column :versions, :kind, :integer
  end
end
