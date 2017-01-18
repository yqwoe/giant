namespace :db do
  desc 'import users'
  task users: :environment do
    require 'csv'

    CSV.foreach 'db/users.csv', headers: true do |r|
      name = r[0]
      mobile = r[1]
      email = "#{mobile}@139.com"
      password = mobile[-6..-1]
      user = User.new name: name,
        mobile: mobile,
        email: email,
        password: password,
        password_confirmation: password

      user.roles = :member if r[6] == '年卡'
      car = user.cars.build
      brand, model = r[3].split '-'
      car_brand = CarBrand.find_by(cn_name: brand)

      car.car_model = car_brand.car_models.find_by_cn_name model
      car.licensed_id = r[4]
      car.joined_at = r[7]
      car.valid_at = r[8]
      car.save!

      user.save!

    end
  end
end
