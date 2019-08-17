FactoryBot.define do
  factory :exchange_rate do
    from_asset_id { 1 }
    to_asset_id { 1 }
    value { "" }
    inverse_value { "" }
  end
end
