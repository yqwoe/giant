class AddFineToViolations < ActiveRecord::Migration[5.0]
  def change
    add_column :violations, :fine, :integer
  end
end
