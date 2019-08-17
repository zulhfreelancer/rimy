module AccountGoverner
    extend ActiveSupport::Concern
    
    # return integer i.e. 5 if team size is 5
    def update_approvals_needed(team_id)
        team = Team.find(team_id)
        num_of_members = team.users.size
        accounts = team.accounts
        accounts.update_all(approvals_needed: num_of_members)
    end
end
