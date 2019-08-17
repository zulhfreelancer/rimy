class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :sender_account_id
      t.integer :recipient_account_id
      t.integer :sender_asset_id
      t.integer :recipient_asset_id
      t.bigint :sender_amount
      t.bigint :recipient_amount
      t.boolean :is_complete
      
      t.timestamps
    end
  end
end
