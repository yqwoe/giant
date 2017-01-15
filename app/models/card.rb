class Card < ApplicationRecord
  enum status: [:inactived, :actived]

end
