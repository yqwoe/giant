FactoryGirl.define do
  factory :card do
    sequence(:cid)  { |n| "22222#{n}" }
    sequence(:pin)  { |n| "12345#{n}" }
    range 1
  end
end
