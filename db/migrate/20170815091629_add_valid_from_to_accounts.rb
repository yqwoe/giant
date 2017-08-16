class AddValidFromToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :valid_from, :date
    add_column :accounts, :valid_to, :date
  end
end
