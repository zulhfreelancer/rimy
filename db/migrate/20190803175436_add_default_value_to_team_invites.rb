class AddDefaultValueToTeamInvites < ActiveRecord::Migration[5.2]
  def up
    change_column_default :team_invites, :status, 0
  end

  def down
      change_column_default :team_invites, :status, nil
  end
end
