namespace :db do
  desc 'import selected'
  task selected_shops: :environment do
    require 'csv'
    CSV.foreach 'db/selected_shops.csv' do |row|
      begin
        name = row[0]
        star = row[1]
        shop = Shop.find_by_name name
        shop.star = star
        shop.actived!
        shop.save!
      rescue
        puts row
      end
    end
  end
end
