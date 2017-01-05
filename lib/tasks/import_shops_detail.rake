namespace :db do
  desc 'import shops data'
  task shops_details: :environment do
    puts 'importing shops...'

    require 'csv'
    CSV.foreach('db/shops_detail.csv', headers: true) do |row|
      user = User.find_by_mobile row[6]
      user = User.new unless user
      user.name = row[5]
      user.mobile = row[6]
      user.password = row[7] * 2
      user.email = "#{row[6]}@139.com"
      user.roles = 4
      shop = user.shops.build
      shop[:name] = row[0]
      shop[:phone] = row[1]
      shop[:image] = row[2]

      d1, d2 =  row[3].split('至')
      duration = Date.parse(d1)..Date.parse(d2)
      shop[:duration] = duration

      shop[:openning] = row[4]

      shop[:city] = row[8]
      shop[:position] = row[9].split(':')

      begin
        user.save!
      rescue Exception => e
        puts row[6]
        puts e.message
      end
    end

    puts 'shops imported! '
  end
end
