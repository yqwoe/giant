namespace :db do
  desc 'import shops data'
  task shops: :environment do
    puts 'importing shops...'

    require 'csv'
    csv_file = ARGV[1]
    begin
      CSV.foreach(csv_file, headers: true) do |row|
        user = User.find_by_mobile row[2].strip
        unless user
          user = User.create mobile: row[2].strip, email: "#{row[2]}@1.com",
            password: '123456', password_confirmation: '123456'
        end

        next if Shop.find_by_name row[0]
        shop = {}
        shop[:name]          = row[0]
        shop[:phone]         = row[1]
        shop[:category]      = row[3]
        shop[:position]      = [row[7], row[6]]
        shop[:image]     = row[9]
        shop[:province], shop[:city], shop[:county], shop[:address] =
          row[6].split(',')
        puts shop
        user.shops.create! shop
      end

      puts 'shops imported! '
    rescue Exception => e
      puts e.message
    end
  end

end
