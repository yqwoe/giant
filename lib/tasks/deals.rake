namespace :db do
  desc "importing deals"
  task deals: :environment do
    puts 'importing deals'

    require 'csv'
    CSV.foreach 'db/deals.csv', headers:true do |row|
      begin
        passwd = "xss#{row[3][3..-1]}"
        user = User.find_by(mobile: row[2])
        user ||= User.find_by(mobile: row[1])
        user ||= User.new(mobile: row[2], email: "#{row[2]}@139.com", password: "#{passwd}")
        unless user
          user = User.find_or_create_by!(mobile: row[1], email: "#{row[1]}@139.com", password: "#{passwd}")
        end
        user.save!
        puts "user #{user.mobile} has been saved!"

        car = Car.find_by(licensed_id: row[3])
        car ||= user.cars.find_or_create_by!(car_model_id: 0, licensed_id: row[3])
        shop = Shop.find_or_create_by! name: row[4]

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
        puts e.message
        byebug
        puts row
        sleep 10
      end
    end
  end
end
