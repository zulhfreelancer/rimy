class TeamsUsers < ApplicationRecord
    self.table_name = "teams_users"
    validates :user_id, :team_id, presence: true
end
