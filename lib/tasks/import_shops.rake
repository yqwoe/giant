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
      shop[:star]  = row[3]
      shop[:category] = row[4]
      shop[:province] = row[5]
      shop[:county]    = row[6]
      shop[:address]   = row[8]
      shop[:position]  = [row[9], row[10]]
      shop[:status]    = 1
      puts shop
      Shop.create! shop
    end

    puts 'shops imported! '
  end
end
