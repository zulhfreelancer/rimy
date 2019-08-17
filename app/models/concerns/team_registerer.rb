module TeamRegisterer
    include AccountGoverner
    extend ActiveSupport::Concern
  
    def link_user_and_team(user, team)
        linked = TeamsUsers.new(user_id: user.id, team_id: team.id).save
        update_approvals = update_approvals_needed(team.id)
        return true if linked && update_approvals > 0
        false
    end
end
