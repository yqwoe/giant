FactoryGirl.define do
  factory :account do
    deposit_by_times 1
    deposit_cash "9.99"
    available_cash "9.99"
    valid_from    Time.zone.now
    valid_to      1.month.from_now

    user
  end
end
