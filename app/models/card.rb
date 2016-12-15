class Card < ApplicationRecord
  enum status: [:inactived, :active]

end
