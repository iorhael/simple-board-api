# frozen_string_literal: true

FactoryBot.define do
  factory :refresh_token do
    jti { SecureRandom.uuid }
    expires_at { 3.days.from_now }
    user { association :user }

    trait :revoked do
      is_revoked { true }
    end

    trait :blacklisted do
      is_blacklisted { true }
    end
  end
end
