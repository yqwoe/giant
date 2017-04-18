class Client < ApplicationRecord
  belongs_to :seller, class_name: 'User'
  belongs_to :custome, class_name: 'User'
end
