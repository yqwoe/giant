namespace :db do
  desc 'import users'
  task users: :environment do
    require 'csv'

    CSV.foreach 'db/users.csv', headers: true do |r|
      begin
        name = r[0]
        mobile = r[1]
        email = "#{mobile}@139.com"
        password = mobile[-6..-1]
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
        brand = r[3]
        model = r[4]
        car_brand = CarBrand.find_or_create_by(cn_name: brand)

        car.car_model = car_brand.car_models.find_by_cn_name model
        car.licensed_id = r[5] unless car
        car.joined_at = r[7]
        car.valid_at = r[8]
        car.save!

        user.save!

      rescue
        puts r
      end
    end
  end
end
