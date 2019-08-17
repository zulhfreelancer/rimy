module AccountsHelper
    def approval_requirement(account)
        return "N/A" if account.accountable_type == "User"
        account.approvals_needed
    end

    # params in array i.e. 
    #     [["Malaysian Ringgit", 2, "Fiat"], ["Amazon", 3, "Stock"], ["Google", 4, "Stock"], ["Netflix", 5, "Stock"]]
    # returns hash i.e.
    #    {"Fiat"=>[["Malaysian Ringgit", 2]], "Stock"=>[["Amazon", 3], ["Google", 4], ["Netflix", 5]]}
    def available_assets_grouped_options(available_assets)
        return {} if available_assets.nil? || available_assets.empty?
        hash = available_assets.group_by{|name, id, type| type}.each{|type, assets| assets.each{|asset| asset.pop}}
        return grouped_options_for_select(hash)
    end

    def account_type(accountable_type)
        accountable_type == "User" ? "Personal" : "Team"
    end
end
