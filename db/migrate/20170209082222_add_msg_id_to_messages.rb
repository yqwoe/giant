class AddMsgIdToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :msg_id, :string
  end
end
