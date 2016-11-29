class CreateCars < ActiveRecord::Migration[5.0]
  def change
    create_table :cars do |t|
      t.integer :car_model_id
      t.string  :licensed_id
      t.integer :status
      t.date    :joined_at
      t.date    :visited_at
      t.integer :user_id
      t.string  :city

      t.timestamps
    end
  end
end
