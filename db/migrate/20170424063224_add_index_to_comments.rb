class AddIndexToComments < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :comments, [:commentable_id, :commentable_type],
      algorithm: :concurrently
  end
end
