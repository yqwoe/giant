class RemoveUnneededIndexes < ActiveRecord::Migration[5.0]
  def change
    remove_index :inviter_situations, name: "index_inviter_situations_on_inviter_id"
  end
end
