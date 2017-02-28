class AddChannelToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :channel, :integer
  end
end
