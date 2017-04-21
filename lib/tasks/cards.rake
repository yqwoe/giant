namespace :db do
  desc 'generate cards'

  def gen_pin range, num
    rand(range).to_s.rjust(num, "0")
  end

  task cards: :environment do
    require 'csv'
    puts 'start to generate pin'
    CSV.open 'card.csv', 'wb' do |csv|
      50000.times do
        begin
          id  = gen_pin(111111...999999, 6)
          pin = gen_pin(11111111111...99999999999, 11)
          unless GrowingCard.find_by pin: pin
            GrowingCard.create! cid: "G#{id}", pin: "G#{pin}", range: -1
            csv << [id, pin]
            print '.'
          end
        rescue Exception => e
          print '-'
          puts e.message
          retry
        end
      end
      puts
      puts 'Generating pin finished'
    end
  end

end
