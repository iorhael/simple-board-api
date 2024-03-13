# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    name { Faker::Name.first_name }
    password { Faker::Internet.password }

    trait :admin do
      is_admin { true }
    end

    trait :notify_via_telegram do
      notification_method { :telegram }
    end
  end
end
