namespace :db do
  desc "importing deals"
  task deals: :environment do
    puts 'importing deals'

    require 'csv'
    CSV.foreach 'db/deals.csv' do |row|
      begin
        car = Car.find_by_licensed_id row[3]
        shop = Shop.find_by_name row[4]

        deal = {}
        deal[:car_id]       = car.id
        deal[:shop_id]      = shop.id
        deal[:visited_at]   = row[5]
        deal[:cleaned_at]   = row[6]
        deal[:status]       = row[7]
        deal[:comments]     = row[8]
        deal[:commented_at] = row[9]
        deal[:created_at]   = row[10]
        deal[:updated_at]   = row[11]

        Deal.create! deal
      rescue Exception => e
        puts row[0]
        puts e.message
      end
    end
  end
end
