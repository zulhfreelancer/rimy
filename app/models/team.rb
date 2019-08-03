class Team < ApplicationRecord
    include TeamRegisterer

    has_and_belongs_to_many :users
    has_many :team_invites
    has_one :owner, :class_name => "User", :foreign_key => "owner_id"

    validates :owner_id, :name, presence: true
end
