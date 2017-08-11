class CreateVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :versions do |t|
      t.string :number
      t.string :download_url
      t.column :contents, :string, array: true
      t.integer :type

      t.timestamps
    end
  end
end
