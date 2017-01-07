class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :shop_id
      t.integer :user_id
      t.string :content
      t.integer :env_star
      t.integer :service_star
      t.integer :clean_star

      t.timestamps
    end
  end
end
