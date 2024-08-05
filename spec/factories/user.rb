# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    first_name { Faker::Lorem.word }
    last_name { Faker::Lorem.word }
    created_at { DateTime.current.utc }
  end
end
