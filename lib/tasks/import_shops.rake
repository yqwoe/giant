namespace :db do
  desc 'import shops data'
  task shops: :environment do
    puts 'importing shops...'

    require 'csv'
    CSV.foreach('db/carstoredata0223.csv', headers: true) do |row|
      shop = {}
      shop[:name]  = row[0]

      shop[:phone] = row[1]
      shop[:city]  = row[2]
      shop[:star]  = row[4]
      shop[:category] = row[5]
      shop[:province] = row[6]
      shop[:county] = row[8]
      shop[:address]   = row[9]
      shop[:position]  = [row[10], row[11]]
      shop[:status]    = 1
      puts shop
      Shop.create! shop
    end

    puts 'shops imported! '
  end
end
