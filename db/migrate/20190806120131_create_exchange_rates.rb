class CreateExchangeRates < ActiveRecord::Migration[5.2]
  def change
    create_table :exchange_rates do |t|
      t.integer :from_asset_id
      t.integer :to_asset_id
      t.decimal :value
      t.decimal :inverse_value

      t.timestamps
    end
  end
end
