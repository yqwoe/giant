class CreateGrowingUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :growing_users do |t|
      t.string :mobile, uniq: true
      t.integer :growing_card_id

      t.timestamps
    end

  end
end
