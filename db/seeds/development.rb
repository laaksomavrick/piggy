# frozen_string_literal: true

require 'factory_bot'
# rubocop:disable Style/MixinUsage
include FactoryBot::Syntax::Methods
# rubocop:enable Style/MixinUsage

# Create admin user
admin = User.create(email: 'admin@example.com', password: 'Qweqwe1!', first_name: 'Joe', last_name: 'Sixpack')
org = admin.organization

# Create member user
member = User.new(email: 'member@example.com', password: 'Qweqwe1!', first_name: 'Jane', last_name: 'America')
member.organizations << org
member.save

# Create investment_accounts
create(:investment_account, organization: org)
create(:investment_account, organization: org)
create(:investment_account, organization: org)
create(:investment_account, organization: org, is_deleted: true, name: "Should be deleted")