class TeamInvitesController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_team, only: [:new, :create]
    before_action :set_user, only: [:create, :confirm_join]
    before_action :set_invite, only: [:confirm_join, :ignore_if_not_exist, :ignore_if_joined]
    before_action :validate_owner, only: [:new, :create]

    include Pagy::Backend
    include InviteTokenGenerator
    include TeamRegisterer

    def new
        @pagy, @invites = pagy(
            @team.team_invites.includes(:user).all, page: params[:page], items: 10
        )
    end

    def create
        @invite = @team.team_invites.new(user: @user, invite_token: get_new_token)
        if @invite.save
            flash[:notice] = "Invite sent!"
        else
            flash[:errors] = @invite.errors.full_messages
        end
        redirect_to invite_team_path(@team)
    end

    def join
    end

    def confirm_join
        ignore_if_blank; return if performed?
        ignore_if_not_exist; return if performed?
        ignore_if_joined; return if performed?
        if link_user_and_team(current_user, @invite.team) && @invite.joined!
            flash[:notice] = "Invitation complete" and redirect_to teams_path
        end
    end

    private
    def set_team
        @team = Team.find(params[:id])
    end

    def set_user
        @user = User.find_by(email: params[:email])
    end

    def set_invite 
        @invite = TeamInvite.find_by_invite_token(params[:invite_token])
    end

    def ignore_if_blank
        if params[:invite_token].blank?
            flash[:error] = "Invite can not be blank"
            render :join and return
        end
    end

    def ignore_if_not_exist
        if @invite.nil?
            flash[:error] = "Invite code not found"
            render :join and return
        end
    end

    def ignore_if_joined
        if @invite.joined?
            flash[:error] = "Invite code has been used"
            render :join and return
        end
    end

    def validate_owner
        if current_user.id != @team.owner_id
            flash[:error] = "Unauthorized"
            redirect_to teams_path and return
        end
    end

end
