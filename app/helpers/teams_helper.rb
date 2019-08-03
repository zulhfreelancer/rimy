module TeamsHelper
    include Pagy::Frontend

    def team_ownership(team)
        if team.owner_id == current_user.id
            return "Yes"
        end

        return "No"
    end

    def invite_button(team)
        if team.owner_id == current_user.id
            link_to(invite_team_path(team), class: "btn btn-primary") do
                "Invite"
            end
        end
    end
end
