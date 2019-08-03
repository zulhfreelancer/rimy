class TeamsController < ApplicationController
    before_action :authenticate_user!
    
    include Pagy::Backend
    include TeamRegisterer

    def index
        @pagy, @teams = pagy(current_user.teams, page: params[:page], items: 10)
    end

    def new
        @team = current_user.teams.new
    end

    def create
        @team = current_user.teams.new(team_params)
        @team.owner_id = current_user.id
        
        if @team.save
            link_user_and_team(current_user, @team)
            flash[:notice] = "Team created successfully"
            redirect_to teams_path
        else
            flash[:errors] = @team.errors.full_messages
            render 'new'
        end
    end

    private
    def team_params
        params.require(:team).permit(:name)
    end

    
end
