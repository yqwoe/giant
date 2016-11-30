class AddCarIdToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :car_id, :integer
    add_column :deals, :dealsable_id, :integer
    add_column :deals, :dealsable_type, :integer

    add_index :deals, [:dealsable_id, :dealsable_type]
  end
end
