class Asset < ApplicationRecord
    has_many :accounts
    has_many :users, through: :accounts, source: :accountable, source_type: 'User'
    has_many :teams, through: :accounts, source: :accountable, source_type: 'Team'
    has_many :from_exchange_rates, class_name: "ExchangeRate", foreign_key: "from_asset_id"
    has_many :to_exchange_rates, class_name: "ExchangeRate", foreign_key: "to_asset_id"
    has_many :sender_transfers, class_name: "Transfer", foreign_key: "sender_asset_id"
    has_many :recipient_transfers, class_name: "Transfer", foreign_key: "recipient_asset_id"

    scope :fiats, -> { where(type: 'Fiat') }
    scope :stocks, -> { where(type: 'Stock') }

    validates :type, :name, :code, presence: true

    # list of all assets that can be added to user's or team's portfolio
    # returns array i.e. [["Malaysian Ringgit", 2, "Fiat"], ["Amazon", 3, "Stock"], ["Google", 4, "Stock"]]
    def self.available_assets(accountable_type, accountable_id)
        sql = ActiveRecord::Base.send(:sanitize_sql_for_conditions, ["SELECT name, id, type FROM assets WHERE id NOT IN (SELECT assets.id FROM assets LEFT JOIN accounts ON assets.id = accounts.asset_id WHERE accountable_type = ? AND accountable_id = ?) GROUP BY assets.id, assets.type ORDER BY assets.id", accountable_type, accountable_id])
        result = ActiveRecord::Base.connection.execute(sql)
        return result.values
    end
end
