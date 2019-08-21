require 'securerandom'

module Authorizer
    extend ActiveSupport::Concern
  
    def reject_if_unauthorized
        unless (is_real_owner || part_of_the_team)
            flash[:error] = "You are not allowed to perform this action"
            redirect_to root_path and return
        end
    end

    def is_real_owner
        if @accountable.class.name == "User"
            @accountable == current_user
        end
    end

    def part_of_the_team
        if @accountable.class.name == "Team"
            TeamsUsers.where(team_id: @accountable.id).pluck(:user_id).include?(current_user.id)
        end
    end
end
