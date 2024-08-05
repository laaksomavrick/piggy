# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it 'creates a default org when none set' do
    user = create(:user)
    expect(user.organizations.count).not_to be(0)
    expect(user.organizations.first.name).to eq(I18n.t('models.organization.fields.name.default'))
  end
end
