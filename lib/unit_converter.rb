require 'action_view'
require 'bigdecimal'

class UnitConverter
    extend ActionView::Helpers::NumberHelper

    def self.app_decimal
        ASSET_DECIMAL
    end

    # params
    # - base_int (integer) i.e. 4000000000000000000
    # - scale (integer) i.e. 2
    # returns string i.e. "4.000"
    def self.to_display(base_int, scale = 3, decimal = app_decimal)
        return "0" if base_int.zero?
        num = (BigDecimal(base_int) / (1 * 10**decimal)).truncate(scale) rescue nil
        self.number_with_precision(num, precision: scale).to_s
    end

    # params
    # - display_str (string) i.e. "1" or "1.11"
    # returns integer i.e. 1000000000000000000
    def self.to_base(display_str, decimal = app_decimal)
        return 0 if display_str.empty?
        display = BigDecimal(display_str)
        BigDecimal((1 * 10**decimal) * display).to_s('F').to_i rescue nil
    end
end
