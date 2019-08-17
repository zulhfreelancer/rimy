class Account < ApplicationRecord
  include AccountGoverner
  belongs_to :accountable, polymorphic: true
  belongs_to :asset
  has_many :sender_transfers, class_name: "Transfer", foreign_key: "sender_asset_id"
  has_many :recipient_transfers, class_name: "Transfer", foreign_key: "recipient_asset_id"
  
  validates :account_number, presence: true

  scope :with_assets, -> {includes(:asset).references(:asset)}
  
  after_create :update_team_approvals

  def update_team_approvals
    update_approvals_needed(accountable_id) if accountable_type == "Team"
  end

end
