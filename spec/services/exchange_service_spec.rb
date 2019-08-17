require 'rails_helper'
require 'unit_converter'

RSpec.describe "Service > Exchange" do
    before :all do
        @usd  = create(:fiat, name: "US Dollar", code: "USD")
        @myr  = create(:fiat, name: "Malaysian Ringgit", code: "MYR")
        
        @amzn = create(:stock, name: "Amazon", code: "AMZN")
        @nflx = create(:stock, name: "Netflix", code: "NFLX")
        
        create(:exchange_rate, from: @amzn, to: @usd, value: 1775550000000000000000, inverse_value: 563206000000000)
        create(:exchange_rate, from: @nflx, to: @myr, value: 1224800000000000000000, inverse_value: 816459830176355)
        create(:exchange_rate, from: @usd, to: @myr, value: 4000000000000000000, inverse_value: 250000000000000000)
    end

    context "USD to MYR" do
        it "1 USD = 4 MYR" do
            one_usd      = UnitConverter.to_base("1.00")
            exchange     = ExchangeService.new(from_asset_id: @usd.id, to_asset_id: @myr.id, from_amount: one_usd)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "4.000"
        end
    
        it "9.99 USD = 39.96 MYR" do
            one_usd      = UnitConverter.to_base("9.99")
            exchange     = ExchangeService.new(from_asset_id: @usd.id, to_asset_id: @myr.id, from_amount: one_usd)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "39.960"
        end
    end

    context "MYR to USD" do
        it "4 MYR = 1 USD" do
            four_myr     = UnitConverter.to_base("4.00")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @usd.id, from_amount: four_myr)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "1.000"
        end

        it "0.10 MYR = 0.025 USD" do
            point_five   = UnitConverter.to_base("0.1")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @usd.id, from_amount: point_five)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "0.025"
        end
    
        it "0.50 MYR = 0.125 USD" do
            point_five   = UnitConverter.to_base("0.5")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @usd.id, from_amount: point_five)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "0.125"
        end
    
        it "0.99 MYR = 0.247 USD" do
            point_five   = UnitConverter.to_base("0.99")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @usd.id, from_amount: point_five)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "0.247"
        end
    
        it "999.99 MYR = 249.997 USD" do
            point_five   = UnitConverter.to_base("999.99")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @usd.id, from_amount: point_five)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "249.997"
        end
    end

    context "Amazon to USD" do
        it "1 Amazon = 1775.550 USD" do
            one_stock    = UnitConverter.to_base("1")
            exchange     = ExchangeService.new(from_asset_id: @amzn.id, to_asset_id: @usd.id, from_amount: one_stock)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "1775.550"
        end

        it "0.1 Amazon = 177.555 USD" do
            one_stock    = UnitConverter.to_base("0.1")
            exchange     = ExchangeService.new(from_asset_id: @amzn.id, to_asset_id: @usd.id, from_amount: one_stock)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "177.555"
        end
    
        it "999.999 Amazon = 1775548.224 USD" do
            stock_amount = UnitConverter.to_base("999.999")
            exchange     = ExchangeService.new(from_asset_id: @amzn.id, to_asset_id: @usd.id, from_amount: stock_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "1775548.224"
        end
    
        it "0.999 Amazon = 1773.774 USD" do
            stock_amount = UnitConverter.to_base("0.999")
            exchange     = ExchangeService.new(from_asset_id: @amzn.id, to_asset_id: @usd.id, from_amount: stock_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "1773.774"
        end
    end

    context "USD to Amazon" do
        it "1 USD = 0.00056 Amazon" do
            fiat_amount  = UnitConverter.to_base("1")
            exchange     = ExchangeService.new(from_asset_id: @usd.id, to_asset_id: @amzn.id, from_amount: fiat_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result, 5)
            expect(result_human).to eq "0.00056"
        end
    
        it "0.1 USD = 0.00005 Amazon" do
            fiat_amount  = UnitConverter.to_base("0.1")
            exchange     = ExchangeService.new(from_asset_id: @usd.id, to_asset_id: @amzn.id, from_amount: fiat_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result, 5)
            expect(result_human).to eq "0.00005"
        end

        it "999.99 USD = 0.563 Amazon" do
            fiat_amount  = UnitConverter.to_base("999.99")
            exchange     = ExchangeService.new(from_asset_id: @usd.id, to_asset_id: @amzn.id, from_amount: fiat_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "0.563"
        end
    end

    context "Netflix to MYR" do
        it "1 Netflix = 1224.800 MYR" do
            stock_amount = UnitConverter.to_base("1")
            exchange     = ExchangeService.new(from_asset_id: @nflx.id, to_asset_id: @myr.id, from_amount: stock_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "1224.800"
        end
    
        it "0.1 Netflix = 122.480 MYR" do
            stock_amount = UnitConverter.to_base("0.1")
            exchange     = ExchangeService.new(from_asset_id: @nflx.id, to_asset_id: @myr.id, from_amount: stock_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "122.480"
        end
    
        it "999.99 Netflix = 1224787.751 MYR" do
            stock_amount = UnitConverter.to_base("999.99")
            exchange     = ExchangeService.new(from_asset_id: @nflx.id, to_asset_id: @myr.id, from_amount: stock_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "1224787.752"
        end

        it "0.999 Netflix = 1223.575 MYR" do
            stock_amount = UnitConverter.to_base("0.999")
            exchange     = ExchangeService.new(from_asset_id: @nflx.id, to_asset_id: @myr.id, from_amount: stock_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "1223.575"
        end
    end

    context "MYR to Netflix" do
        it "1 MYR = 0.00081 Netflix" do
            fiat_amount  = UnitConverter.to_base("1")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @nflx.id, from_amount: fiat_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result, 5)
            expect(result_human).to eq "0.00081"
        end

        it "0.1 MYR = 0.00008 Netflix" do
            fiat_amount  = UnitConverter.to_base("0.1")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @nflx.id, from_amount: fiat_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result, 5)
            expect(result_human).to eq "0.00008"
        end

        it "999.99 MYR = 0.816 Netflix" do
            fiat_amount  = UnitConverter.to_base("999.99")
            exchange     = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @nflx.id, from_amount: fiat_amount)
            result       = exchange.get_result_amount
            result_human = UnitConverter.to_display(result)
            expect(result_human).to eq "0.816"
        end
    end

    context "Exchange rate is not found" do
        it "[USD <-> Netflix] throws when no exchange rate is found" do
            fiat_amount = UnitConverter.to_base("1")
            exchange    = ExchangeService.new(from_asset_id: @usd.id, to_asset_id: @nflx.id, from_amount: fiat_amount)
            expect {
                result  = exchange.get_result_amount
            }.to raise_error(ExchangeService::ExchangeRateNotFoundError)
        end
    
        it "[MYR <-> Amazon]  throws when no exchange rate is found" do
            fiat_amount = UnitConverter.to_base("1")
            exchange    = ExchangeService.new(from_asset_id: @myr.id, to_asset_id: @amzn.id, from_amount: fiat_amount)
            expect {
                result  = exchange.get_result_amount
            }.to raise_error(ExchangeService::ExchangeRateNotFoundError)
        end
    end

end
