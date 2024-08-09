# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InvestmentAccount, type: :model do
  it 'can be created' do
    investment_account = create(:investment_account)
    expect(investment_account).not_to be_nil
    expect(investment_account.valid?).to be true
  end

  it 'must belong to an organization' do
    expect do
      create(:investment_account, organization_id: nil)
    end.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Organization must exist')
  end

  it 'must have a name' do
    expect do
      create(:investment_account, name: nil)
    end.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
  end
end
