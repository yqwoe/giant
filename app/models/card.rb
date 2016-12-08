class Card < ApplicationRecord
  enum status: [:inactivited, :activited]

end
