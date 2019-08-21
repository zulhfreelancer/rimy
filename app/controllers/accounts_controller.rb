class AccountsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_accountable
    before_action :reject_if_unauthorized
    before_action :set_accountable_type, only: [:new]
    
    include Pagy::Backend
    include Authorizer

    def index
        @pagy, @accounts = pagy(@accountable.accounts.with_assets, page: params[:page], items: 10)
    end

    def new
        @available = Asset.available_assets(@account_type, @accountable.id)
    end

    def create
        asset = Asset.find(params[:asset_id])
        is_created, errors = @accountable.register_an_account(asset)
        if is_created
            flash[:notice] = "New account created"
            redirect_to polymorphic_path([@accountable, Account])
        else
            flash[:errors] = errors
            render :new
        end
    end

    private
    def set_accountable
        params.each do |name, value|
            if name =~ /(user|team)_id$/ # avoid capturing `asset_id`
                return @accountable = $1.classify.constantize.find(value)
            end
        end
        return @accountable = current_user
    end

    def set_accountable_type
        @account_type = @accountable.model_name.human
    end

end
