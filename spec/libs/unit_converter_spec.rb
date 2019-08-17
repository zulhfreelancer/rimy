require 'spec_helper'
require 'unit_converter'

describe "Lib > Unit Converter" do
    context "base (integer) to display (string)" do
        it "1000000000000000000 -> 1.000" do
            test_string = 1000000000000000000
            result = UnitConverter.to_display(test_string)
            expect(result).to eq "1.000"
        end
    
        it "1123456789012345678 -> 1.123" do
            test_string = 1123456789012345678
            result = UnitConverter.to_display(test_string)
            expect(result).to eq "1.123"
        end
    
        it "9999999999999999999 -> 9.999" do
            test_string = 9999999999999999999
            result = UnitConverter.to_display(test_string)
            expect(result).to eq "9.999"
        end
    
        it "999999999999999999999 -> 9.999" do
            test_string = 999999999999999999999
            result = UnitConverter.to_display(test_string)
            expect(result).to eq "999.999"
        end
    end

    context "display (string) to base (integer)" do
        it "1 -> 1000000000000000000" do
            test_string = "1"
            result = UnitConverter.to_base(test_string)
            expect(result).to eq 1000000000000000000
        end
    
        it "1.123456789012345678 -> 1123456789012345678" do
            test_string = "1.123456789012345678"
            result = UnitConverter.to_base(test_string)
            expect(result).to eq 1123456789012345678
        end
    
        it "1.1234567890123456789 -> 1123456789012345678" do
            test_string = "1.1234567890123456789"
            result = UnitConverter.to_base(test_string)
            # mathematically, it should be 1123456789012345678.9 - since we only stores
            # whole numbers and no decimal points, the "*.9" should be dropped
            expect(result).to eq 1123456789012345678
        end
    
        it "999.999999999999999999 -> 999999999999999999999" do
            test_string = "999.999999999999999999"
            result = UnitConverter.to_base(test_string)
            expect(result).to eq 999999999999999999999
        end
    end

end
