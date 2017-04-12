class AddIndexToClients < ActiveRecord::Migration[5.0]
    disable_ddl_transaction!

    def change
      add_index :clients, :custom_id, algorithm: :concurrently
    end
end
