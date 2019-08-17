FactoryBot.define do
  factory :account do
    account_number { "123456789" }
    accountable { nil }
    approvals_needed { 1 }
    asset_id { 1 }
    balance { "1000000000" }
  end
end
