namespace :db do
  desc 'import shops data'
  task shops: :environment do
    puts 'importing shops...'

    require 'csv'
    CSV.foreach('db/shops.csv') do |row|
      shop = {}
      shop[:name] = row[1]
      shop[:phone] = row[2]
      shop[:category] = row[5]
      shop[:province], shop[:city], shop[:county], shop[:address], _ = row[6].split(',')

      puts shop
      Shop.create! shop
    end

    puts 'shops imported! '
  end
end
