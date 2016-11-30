class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.integer :car_id
      t.integer :shop_id
      t.datetime :visited_at
      t.datetime :cleaned_at
      t.integer :status
      t.string :comments
      t.datetime :commented_at

      t.timestamps
    end
  end
end
