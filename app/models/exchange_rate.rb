class ExchangeRate < ApplicationRecord
    belongs_to :from, class_name: "Asset", foreign_key: "from_asset_id"
    belongs_to :to, class_name: "Asset", foreign_key: "to_asset_id"

    validates :value, :inverse_value, presence: true
end
