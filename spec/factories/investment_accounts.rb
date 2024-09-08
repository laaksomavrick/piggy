# frozen_string_literal: true

FactoryBot.define do
  factory :investment_account do |f|
    organization factory: :organization
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    contribution_limit { Faker::Number.number(digits: 6) }

    after :create do |investment_account|
      create_list :transaction, 10, investment_account: investment_account
    end
  end
end
