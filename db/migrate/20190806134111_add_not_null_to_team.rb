class AddNotNullToTeam < ActiveRecord::Migration[5.2]
  def change
    change_column :teams, :name, :string, null: false
    change_column :teams, :owner_id, :integer, null: false
  end
end
