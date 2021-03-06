class SuiteOrder < ApplicationRecord
  belongs_to :suite
  belongs_to :coupon
  belongs_to :users

  enum state: [:created, :canceled, :failed, :sucess, :verified]
  enum payment_gateway: [:alipay, :wxpay]
end
