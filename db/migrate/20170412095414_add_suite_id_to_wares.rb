class AddSuiteIdToWares < ActiveRecord::Migration[5.0]
  def change
    add_column :wares, :suite_id, :integer
  end
end
