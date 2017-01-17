namespace :db do
  desc 'import shops details'
  task shop_detail: :environment do
    require 'csv'
    CSV.foreach 'db/shops_detail.csv', headers: true do |row|
      name     = row[0]
      img_url  = row[1]
      openning = row[2]
      mobile   = row[3]
      password = row[4].size >= 6 ? row[4] : row[4] * 2

      shop = Shop.find_by name: name
      shop.image = img_url.split('/').last.downcase
      shop.openning = openning

      # byebug
      u = User.find_by mobile: mobile
      unless u
        u = User.new mobile: mobile,
          email: "#{mobile}@139.com",
          password: password,
          password_confirmation: password
      end
      puts u.mobile
      shop.user = u
      shop.save!
      u.save!
    end
  end
end
