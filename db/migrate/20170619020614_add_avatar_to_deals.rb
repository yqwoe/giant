class AddAvatarToDeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :avatar, :string
  end
end
