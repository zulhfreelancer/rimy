puts "=== Creating fiats ==="
fiats = [
    {
        "name": "US Dollar",
        "code": "USD"
    },
    {
        "name": "Malaysian Ringgit",
        "code": "MYR"
    }
]

fiats.each do |fiat|
    Fiat.create(name: fiat[:name], code: fiat[:code])
end

puts "=== Creating stocks ==="
stocks = [
    {
        "name": "Amazon",
        "code": "AMZN"
    },
    {
        "name": "Google",
        "code": "GOOGL"
    },
    {
        "name": "Netflix",
        "code": "NFLX"
    }
]

stocks.each do |stock|
    Stock.create(name: stock[:name], code: stock[:code])
end

puts "=== Creating exchange rates ==="
rates = [
    {
        "from_code": "AMZN",
        "to_code": "USD",
        "value": 1775550000000000000000,
        "inverse_value": 563206000000000
    },
    {
        "from_code": "GOOGL",
        "to_code": "USD",
        "value": 1160910000000000000000,
        "inverse_value": 861393000000000
    },
    {
        "from_code": "NFLX",
        "to_code": "USD",
        "value": 306200000000000000000,
        "inverse_value": 3265839000000000
    },
    {
        "from_code": "AMZN",
        "to_code": "MYR",
        "value": 7102200000000000000000, 
        "inverse_value": 140801441806764
    },
    {
        "from_code": "GOOGL",
        "to_code": "MYR",
        "value": 4643640000000000000000, 
        "inverse_value": 215348304347451
    },
    {
        "from_code": "NFLX",
        "to_code": "MYR",
        "value": 1224800000000000000000, 
        "inverse_value": 816459830176355
    },
    {
        "from_code": "USD",
        "to_code": "MYR",
        "value": 4000000000000000000, 
        "inverse_value": 250000000000000000
    }
]

rates.each do |rate|
    to = Asset.find_by_code(rate[:to_code])
    from = Asset.find_by_code(rate[:from_code])
    ExchangeRate.create(
        to: to, 
        from: from, 
        value: rate[:value], 
        inverse_value: rate[:inverse_value]
    )
end

puts "=== Done ==="
