# This is not the final implementation of how remove cash should be done.
# I added this class just for the sake of app and demo completeness.
# The main point here is to trigger transfer function for removing cash.
class WithdrawalsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_asset
    before_action :set_account
    before_action :set_accountable
    before_action :reject_if_unauthorized

    include Authorizer

    def new
        @asset_code = @asset.code
        @account_number = @account.account_number
    end
    
    def create
        # TODO - transfer X fiat from @account_number to 0 address 
        flash[:notice] = "Withdrawal request submitted"
        redirect_to polymorphic_path([@accountable, Account])
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

    def set_accountable
        @accountable = @account.accountable
    end

end
