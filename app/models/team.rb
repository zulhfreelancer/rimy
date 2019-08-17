class Team < ApplicationRecord
    include TeamRegisterer
    include AccountRegisterer
    
    has_and_belongs_to_many :users
    has_one :owner, class_name: "User", foreign_key: "owner_id"
    has_many :team_invites

    validates :owner_id, :name, presence: true
end
