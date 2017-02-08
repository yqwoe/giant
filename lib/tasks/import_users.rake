namespace :db do
  desc 'import users'
  task users: :environment do
    require 'csv'
    fo = File.open('db/import_user.log', 'a+')
    puts'Start to import users ...'
    success, failed = 0, 0
    CSV.foreach 'db/users.csv', headers: true do |r|
      begin
        name = r[0]
        mobile = r[1]
        email = "#{mobile}@139.com"
        password = '123456' #mobile[-6..-1]
        user = User.find_by mobile: mobile
        unless user
          user = User.new name: name,
            mobile: mobile,
            email: email,
            password: password,
            password_confirmation: password
        end

        user.roles = :member if r[6] == '年卡'

        user.save!

        car = user.cars.find_or_create_by licensed_id: r[5]
        brand = r[4]
        model = r[4]
        car_brand = CarBrand.find_or_create_by(cn_name: brand)

        car.car_model = car_brand.car_models.find_by_cn_name model
        car.licensed_id = r[5] unless car
        car.joined_at = r[7]
        car.valid_at = r[8]
        car.save!

        user.save!
        print '.'
        success = success + 1
      rescue Exception => e
        fo.puts r
        fo.puts e.message
        print '-'
        failed = failed + 1
      end
    end
    fo.close
    puts
    puts "#{success} users have been imported, #{failed} failed!"
  end
end
