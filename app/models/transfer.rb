class Transfer < ApplicationRecord
    belongs_to :sender_account, class_name: "Account", foreign_key: "sender_account_id"
    belongs_to :recipient_account, class_name: "Account", foreign_key: "recipient_account_id"
    belongs_to :sender_asset, class_name: "Asset", foreign_key: "sender_asset_id"
    belongs_to :recipient_asset, class_name: "Asset", foreign_key: "recipient_asset_id"
end
