class ShopCity < ApplicationRecord
  enum status: [:unactived, :actived]
end
