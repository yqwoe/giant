class AddPackageSizeToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :package_size, :float
  end
end
