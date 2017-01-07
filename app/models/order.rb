class Order < ApplicationRecord
  enum :payment_gateway => [:alipay, :weixin]
  enum platform: [:ios, :android]
  enum status: [:created, :finished, :canceled]
end
