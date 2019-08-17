class RedirectsController < ApplicationController
    before_action :authenticate_user!

    # because routes doesn't has access to current_user
    def to_user_accounts
        redirect_to polymorphic_path([current_user, Account])
    end

end
