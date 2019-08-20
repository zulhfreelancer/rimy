# This is not the final implementation of how add cash should be done.
# I added this class just for the sake of app and demo completeness.
# The main point here is to trigger transfer function for adding cash.
class TopupsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_asset
    before_action :set_account

    def new
        @asset_name = @asset.name
        @asset_code = @asset.code
        @account_number = @account.account_number
    end

    def create
        accountable = @account.accountable
        if params[:intent] == "cancel"
            flash[:error] = "Topup cancelled"
        else
            # TODO - transfer 100 fiat from 0 address to @account_number
            flash[:notice] = "Topup success"
        end
        redirect_to polymorphic_path([accountable, Account])
    end

    private
    def set_asset
        @asset = Asset.find_by_id(params[:asset_id])
        redirect_to root_path, flash: { error: "Asset not found" } if @asset.nil?
    end

    def set_account
        @account = Account.find_by_account_number(params[:account_number])
        redirect_to root_path, flash: { error: "Account not found" } if @account.nil?
    end

end
