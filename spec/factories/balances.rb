FactoryBot.define do
  factory :balance do
    balanceable { nil }
    account { nil }
    amount { "" }
  end
end
