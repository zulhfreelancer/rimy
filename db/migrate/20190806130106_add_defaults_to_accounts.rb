class AddDefaultsToAccounts < ActiveRecord::Migration[5.2]
  def up
    change_column_default :accounts, :approvals_needed, 1
    change_column_default :accounts, :balance, 0
  end

  def down
    change_column_default :accounts, :approvals_needed, nil
    change_column_default :accounts, :balance, nil
  end
end
