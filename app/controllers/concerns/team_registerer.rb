module TeamRegisterer
    extend ActiveSupport::Concern
  

    def link_user_and_team(user, team)
        tu = TeamsUsers.new(user_id: user.id, team_id: team.id)
        tu.save
    end
end
