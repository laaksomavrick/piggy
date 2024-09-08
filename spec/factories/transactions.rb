# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    investment_account factory: :investment_account
    amount { Faker::Number.between(from: -1_000_000, to: 1_000_000) }
  end
end
