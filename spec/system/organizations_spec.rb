# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organizations' do
  let!(:user) { create(:user) }

  describe 'index page' do
    context 'when user is not authenticated' do
      it 'redirects to sign-in' do
        visit organizations_path
        expect(page).to have_current_path('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      before do
        sign_in user
      end

      it 'shows organization members' do
        visit organizations_path
        expect(page).to have_content(user.full_name)
        expect(page).to have_content(user.membership.role.capitalize)
      end
    end
  end
end
