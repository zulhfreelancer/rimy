require 'unit_converter'

module ApplicationHelper
    def flash_class(level)
        case level
            when "notice"  then "alert alert-info"
            when "success" then "alert alert-success"
            when "error"   then "alert alert-danger"
            when "alert"   then "alert alert-warning"
        end
    end

    def balance_formatter(balance, asset_type)
        case asset_type
            when "Stock" then UnitConverter.to_display(balance, 5)
            when "Fiat"  then UnitConverter.to_display(balance)
        end
    end
end
