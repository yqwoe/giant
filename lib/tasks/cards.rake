namespace :db do
  desc 'generate cards'

  def gen_pin range, num
    rand(range).to_s.rjust(num, "0")
  end

  task cards: :environment do
    require 'csv'
    CSV.open 'card.csv', 'wb' do |csv|
      5000.times do
        id  = gen_pin(111111...999999, 6).gsub('4', '8')
        pin = gen_pin(111111111111...999999999999, 11)
        csv << [id, pin]
        Card.create! cid: id, pin: pin
        puts id
      end
    end
  end

end
