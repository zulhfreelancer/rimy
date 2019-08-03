class AddInviteTokenIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :team_invites, :invite_token
  end
end
