namespace :db do
  desc 'import cars information'
  task cars: :environment do
    require 'csv'

    CSV.foreach('db/cars.csv') do |row|
      begin
        user = {}
        user[:name]     = row[1]
        user[:mobile]   = row[2]
        user[:email]    = "#{user[:mobile]}@139.com"
        user[:password] = row[4] && row[4].length == 7 ? "xss#{row[4][3..-1]}": '12341234'
        user[:password_confirmation] = user[:password]
        member = User.find_by(mobile: user[:mobile])
        member ||= User.create! user
        puts "member #{user[:name]} has been inserted!"
        puts user

        car = {}
        car[:user_id] = member.id
        car[:city]       = row[3]
        car[:licensed_id] = row[4]
        car[:car_model_id]  = car_model(row[5])
        car[:status]     = car_status(row[6])
        car[:joined_at]  = row[7]
        car[:valid_at]   = row[8]
      rescue Exception => e
        puts e.message
        puts row[0]
      ensure
        Car.find_by_licensed_id(row[4]) || Car.create!(car)
        next
      end
    end
  end

  def car_model str
    brand_name, car_model_name = str.split '-'
    brand = CarBrand.find_or_create_by cn_name: brand_name
    brand.car_models.find_or_create_by(cn_name: car_model_name).id
  end

  def car_status str
    case str.strip
    when '年卡'
      return 1
    when '体验客户'
      return 0
    else
      nil
    end
  end
end
