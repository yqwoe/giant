class CreateDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :devices do |t|
      t.belongs_to :user
      t.string :uuid
      t.timestamps
    end
  end
end
