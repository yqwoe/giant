namespace :db do
  task dadi: :environment do
    require 'csv'

    CSV.foreach 'db/zhongyuan_cards.csv' do |r|
      card2 = Card.find_by cid: r[0].strip
      if card2
        card2.update_attributes! channel: :zhumadian, range: 9
        next
      end
      card = Card.find_by pin: r[1].strip
      if card
        card.update_attributes! cid: r[0].strip, channel: :zhongyuan, range: 9
        puts "card #{r[0]} range has been changed!"
      else
        Card.create! cid: r[0], pin: r[1], channel: :zhongyuan, range: 9
      end
    end
  end
end
