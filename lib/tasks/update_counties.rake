namespace :db do
  desc 'update shops data'
  task counties: :environment do
    puts 'importing shops...'

    require 'csv'
    CSV.foreach('db/counties.csv', headers: true) do |row|
      shop = Shop.find_by name: row[0]
      if shop
        shop.county = row[3]
        shop.save!
      else
        puts row[0]
      end
    end

    puts 'shops imported! '
  end
end
