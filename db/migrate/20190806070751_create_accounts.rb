class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :account_number
      t.references :accountable, polymorphic: true
      t.integer :approvals_needed
      t.integer :asset_id
      t.decimal :balance

      t.timestamps
    end
  end
end
