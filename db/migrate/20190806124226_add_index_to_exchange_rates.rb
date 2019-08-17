class AddIndexToExchangeRates < ActiveRecord::Migration[5.2]
  def change
    add_index :exchange_rates, [:from_asset_id, :to_asset_id]
  end
end
