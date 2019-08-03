class CreateTeamInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :team_invites do |t|
      t.integer :status
      t.string :invite_token
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
