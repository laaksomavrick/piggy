# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'can be created' do
    transaction = create(:transaction)
    expect(transaction).not_to be_nil
    expect(transaction.valid?).to be true
  end

  it 'is a contribution' do
    transaction = create(:transaction, amount: 5000)
    expect(transaction.transaction_type).to eq 'contribution'
  end

  it 'is a withdrawal' do
    transaction = create(:transaction, amount: -5000)
    expect(transaction.transaction_type).to eq 'withdrawal'
  end
end
