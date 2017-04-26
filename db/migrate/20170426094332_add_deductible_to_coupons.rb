class AddDeductibleToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :deductible, :float
  end
end
