FactoryBot.define do
  factory :fiat do
    type { "Fiat" }
    sequence(:name) {|n| "FiatName-#{n}"}
    sequence(:code) {|n| "FiatCode-#{n}"}
  end
end
