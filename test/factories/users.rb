FactoryGirl.define do
  factory :user do
    sequence(:mobile)  { |n| '13811112' + "#{n.to_s.rjust(3, '0')}" }
    sequence(:email)   { |n| "roc#{n}@g.cn" }
    password '12341234'
    password_confirmation '12341234'
  end
end
