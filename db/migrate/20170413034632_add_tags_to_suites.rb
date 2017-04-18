class AddTagsToSuites < ActiveRecord::Migration[5.0]
  def change
    add_column :suites, :tags, :integer
    add_column :suites, :avatar, :string
  end
end
