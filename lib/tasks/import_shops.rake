namespace :db do
  desc 'import shops data'
  task shops: :environment do
    puts 'importing shops...'

    require 'csv'
    CSV.foreach('db/carstoredata.csv', headers: true) do |row|
      shop = {}
      shop[:name]  = row[0]
      shop[:phone] = row[1]
      shop[:city]  = row[2]
      shop[:category] = row[3]
      shop[:province] = row[4]
      shop[:county]    = row[5]
      shop[:address]   = row[6]
      shop[:position]  = [row[7], row[8]]

      puts shop
      Shop.create! shop
    end

    puts 'shops imported! '
  end
end
