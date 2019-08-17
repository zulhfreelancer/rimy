class AddIndexToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_index :accounts, [:accountable_id, :asset_id]
  end
end
