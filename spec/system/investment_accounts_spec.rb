# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Investment Accounts' do
  let!(:user) { create(:user) }
  let!(:investment_accounts) { create_list(:investment_account, 3, organization: user.organization) }

  describe 'index page' do
    context 'when user is not authenticated' do
      it 'redirects to sign-in' do
        visit investment_accounts_path
        expect(page).to have_current_path('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      before do
        sign_in user
      end

      it 'shows investment accounts' do
        visit investment_accounts_path
        investment_accounts.each do |account|
          expect(page).to have_content(account.name)
        end
      end
    end
  end
end
