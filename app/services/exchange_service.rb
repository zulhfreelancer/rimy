class ExchangeService
    class ExchangeRateNotFoundError < StandardError; end
    attr_reader :from_asset_id, :to_asset_id, :from_amount

    def initialize(params)
        @from_asset_id  = params[:from_asset_id] 
        @to_asset_id    = params[:to_asset_id]   
        @from_amount    = params[:from_amount]
    end

    def get_exchange_rate
        er = ExchangeRate.find_by(from_asset_id: from_asset_id, to_asset_id: to_asset_id) 
        return er.value if er.present?

        er_inv = ExchangeRate.find_by(from_asset_id: to_asset_id, to_asset_id: from_asset_id) 
        return er_inv.inverse_value if er_inv.present?

        raise ExchangeRateNotFoundError.new("Exchange rate not found for this asset pairs")
    end

    def get_result_amount
        rate   = get_exchange_rate
        result = rate * from_amount

        # normalize and ensure no floating point (returns integer)
        return (result / (1 * 10**ASSET_DECIMAL)).round
    end
end
