namespace :db do
  desc 'import shops data'
  task shops: :environment do
    puts 'importing shops...'

    require 'csv'
    CSV.foreach('db/shops.csv') do |row|
      puts row
    end

    puts 'shops imported! '
  end
end
