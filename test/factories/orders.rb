FactoryGirl.define do
  factory :order do
    user_id 1
    state ""
    payment_gateway 1
    trade_no 1
    price 1.5
    quantity 1
    distcount 1.5
    subject "MyString"
  end
end
