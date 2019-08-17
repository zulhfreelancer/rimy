require 'rails_helper'

RSpec.describe "Model > Asset", type: :model do
    it ".fiats class/scope method return all fiats" do
        fiat_1 = create(:fiat, code: "EUR")
        fiat_2 = create(:fiat, code: "JPY")
        stock  = create(:stock, code: "FB")
        expect(Asset.fiats.pluck(:code)).to eq ["EUR", "JPY"]
    end

    it ".stocks class/scope method return all stocks" do
        stock_1 = create(:stock, code: "FB")
        stock_2 = create(:stock, code: "NVDA")
        fiat    = create(:fiat, code: "USD")
        expect(Asset.stocks.pluck(:code)).to eq ["FB", "NVDA"]
    end
end
