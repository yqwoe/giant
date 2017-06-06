FactoryGirl.define do
  factory :order do
    state ""
    payment_gateway 0
    trade_no 'ios20170505153834959'
    total_amount 0.01
    quantity 1
    subject "become VIP"
    car
  end
end
