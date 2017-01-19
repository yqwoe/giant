namespace :db do
  task import_cards: :environment do
    require 'csv'

    CSV.foreach 'db/unactived_cards.csv' do |r|
      Card.create! cid: r[0], pin: r[2]
    end
  end
end
