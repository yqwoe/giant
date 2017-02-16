class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string :title
      t.string :img_url

      t.timestamps
    end
  end
end
