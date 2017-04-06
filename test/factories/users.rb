FactoryGirl.define do
  factory :user do
    sequence(:mobile)  { |n| '1381111222' + "#{n}" }
    sequence(:email)   { |n| "roc#{n}@g.cn" }
    password '12341234'
    password_confirmation '12341234'
  end
end
