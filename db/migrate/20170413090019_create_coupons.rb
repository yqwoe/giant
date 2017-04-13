class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :avatar
      t.integer :status, defaul: 0

      t.timestamps
    end
  end
end
