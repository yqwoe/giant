class Order < ApplicationRecord
  belongs_to :car

  enum :payment_gateway => [:alipay, :weixin]
  enum platform: [:ios, :android]
  enum status: [:created, :canceled, :failed, :success]


  #TODO: 添加定时任务，如果24小时之后还没完成，则标注状态为:canceled
end
