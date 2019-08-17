FactoryBot.define do
  factory :transfer do
    sender { "MyString" }
    recipient { "MyString" }
    sender_asset_id { 1 }
    recipient_asset_id { 1 }
    is_complete { false }
    sender_amount { "" }
    recipient_amount { "" }
  end
end
