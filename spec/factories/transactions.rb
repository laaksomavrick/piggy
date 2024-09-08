FactoryBot.define do
  factory :transaction do
    investment_account factory: :investment_account
    amount { Faker::Number.between(from: -1000000, to: 1000000)}
  end
end
