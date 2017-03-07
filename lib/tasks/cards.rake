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
          id  = gen_pin(111111...999999, 6).gsub('4', '8')
          pin = gen_pin(111111111111...999999999999, 11)
          unless Card.find_by pin: pin
            csv << [id, pin]
            Card.create! cid: id, pin: pin
            print '.'
          end
        rescue
          print '-'
        end
      end
      puts
      puts 'Generating pin finished'
    end
  end

end
