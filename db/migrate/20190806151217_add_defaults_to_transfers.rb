class AddDefaultsToTransfers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :transfers, :sender_amount, 0
    change_column_default :transfers, :recipient_amount, 0
    change_column_default :transfers, :is_complete, false
  end
end
