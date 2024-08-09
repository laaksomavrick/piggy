# frozen_string_literal: true

FactoryBot.define do
  factory :investment_account do
    organization factory: :organization
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    contribution_limit { Faker::Number.number(digits: 6) }
  end
end
