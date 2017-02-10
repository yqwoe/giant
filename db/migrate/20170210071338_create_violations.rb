class CreateViolations < ActiveRecord::Migration[5.0]
  def change
    create_table :violations do |t|
      t.integer :car_id
      t.datetime :vio_date
      t.string :address
      t.integer :penalty
      t.string :legal

      t.timestamps
    end
  end
end
