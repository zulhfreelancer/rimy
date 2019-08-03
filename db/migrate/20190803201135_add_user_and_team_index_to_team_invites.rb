class AddUserAndTeamIndexToTeamInvites < ActiveRecord::Migration[5.2]
  def change
    add_index :team_invites, [:user_id, :team_id], unique: true
  end
end
