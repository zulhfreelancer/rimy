FactoryBot.define do
  factory :stock do
    type { "Stock" }
    sequence(:name) {|n| "StockName-#{n}"}
    sequence(:code) {|n| "StockCode-#{n}"}
  end
end
