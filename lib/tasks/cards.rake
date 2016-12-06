namespace :db do
  desc 'generate cards'

  def gen_pin range, num
    rand(range).to_s.rjust(num, "0")
  end

  task card: :environment do
    require 'csv'
    CSV.open 'card.csv', 'wb' do |csv|
      1000.times do
        id  = gen_pin(111111...999999, 6).gsub('4', '8')
        pin = gen_pin(11111111...99999999, 8).gsub('4', '8')
        csv << [id, pin]
        Card.create! cid: id, pin: pin
        puts id
      end
    end
  end

end
