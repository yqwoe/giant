class SuiteOrder < ApplicationRecord
  belongs_to :suite
  belongs_to :coupon
  belongs_to :users

  enum state: [:created, :success, :canceled]
end
