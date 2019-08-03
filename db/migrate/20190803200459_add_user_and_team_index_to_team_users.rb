class AddUserAndTeamIndexToTeamUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :teams_users, [:user_id, :team_id], unique: true
  end
end
