FactoryBot.define do
    factory :user do
      sequence(:name) {|n| "User #{n}" }
      sequence(:email) {|n| "user-#{n}@example.com" }
      password { "password" }
      password_confirmation { "password" }
    end

    trait :with_team do
      after(:create) do |user|
        team = create(:team, owner_id: user.id)
        create(:teams_users, user_id: user.id, team_id: team.id)
      end
    end
end
