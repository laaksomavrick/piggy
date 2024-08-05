# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it 'creates a default org when none set' do
    user = create(:user)
    expect(user.organizations.count).not_to be(0)
    expect(user.organization.name).to eq(I18n.t('models.organization.fields.name.default'))
    expect(user.organization_membership.role).to eq('admin')
  end

  it 'does not allow a user to have multiple organizations' do
    user = create(:user)
    user.organizations << create(:organization)
    user.save
    expect(user.errors.any?).to be(true)
  end
end
