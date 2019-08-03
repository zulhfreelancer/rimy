class TeamInvite < ApplicationRecord
  belongs_to :user
  belongs_to :team
  enum status: { pending: 0, joined: 1 }

  validate :cannot_invite_owner, on: :create

  def cannot_invite_owner
    if team.owner_id == user_id
      errors[:base] << "You are the owner of this group and already been invited"
    end
  end

end
