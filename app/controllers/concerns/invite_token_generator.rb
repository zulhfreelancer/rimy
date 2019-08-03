require 'securerandom'

module InviteTokenGenerator
    extend ActiveSupport::Concern
  
    def get_new_token
        loop do
            token = generate
            if !TeamInvite.exists?(invite_token: token)
                return token
                break
            end
        end
    end

    def generate
        return SecureRandom.uuid
    end
end
