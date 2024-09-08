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

  describe 'create page' do
    context 'when user is not authenticated' do
      it 'redirects to sign-in' do
        visit new_investment_account_path
        expect(page).to have_current_path('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      before do
        sign_in user
      end

      it 'can create a new investment account' do
        visit new_investment_account_path

        fill_in I18n.t('views.investment_accounts.new.fields.name'), with: 'foo'
        fill_in I18n.t('views.investment_accounts.new.fields.description'), with: 'bar'
        fill_in I18n.t('views.investment_accounts.new.fields.contribution_limit'), with: '100'

        click_on 'Create Investment account'

        expect(page).to have_content(I18n.t('views.investment_accounts.create.flash.success', name: 'foo'))
        expect(page).to have_content('foo')
        expect(page).to have_content('bar')
        expect(page).to have_content('100')
      end

      it 'can create a new without optional fields' do
        visit new_investment_account_path

        fill_in I18n.t('views.investment_accounts.new.fields.name'), with: 'foo'

        click_on 'Create Investment account'

        expect(page).to have_content(I18n.t('views.investment_accounts.create.flash.success', name: 'foo'))
        expect(page).to have_content('foo')
      end

      it 'requires name' do
        visit new_investment_account_path

        fill_in I18n.t('views.investment_accounts.new.fields.description'), with: 'Test Description'
        fill_in I18n.t('views.investment_accounts.new.fields.contribution_limit'), with: '100'

        click_on 'Create Investment account'

        expect(page).to have_current_path(new_investment_account_path)
      end

      it 'shows an error when name is empty' do
        visit new_investment_account_path
        fill_in 'Name', with: ''

        click_on 'Create Investment account'

        expect(page).not_to have_content(I18n.t('views.investment_accounts.create.flash.success', name: ''))
        expect(page).to have_current_path(new_investment_account_path)
      end
    end
  end

  describe 'edit page' do
    let!(:investment_account) { create(:investment_account, organization: user.organization) }

    context 'when user is not authenticated' do
      it 'redirects to sign-in' do
        visit edit_investment_account_path(investment_account)
        expect(page).to have_current_path('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      before do
        sign_in user
      end

      it 'can update an investment account' do
        visit edit_investment_account_path(investment_account)

        fill_in I18n.t('views.investment_accounts.new.fields.name'), with: 'foo'
        fill_in I18n.t('views.investment_accounts.new.fields.description'), with: 'bar'
        fill_in I18n.t('views.investment_accounts.new.fields.contribution_limit'), with: '100000'

        click_on 'Update Investment account'

        expect(page).to have_content(I18n.t('views.investment_accounts.update.flash.success', name: 'foo'))
        expect(page).to have_content('foo')
        expect(page).to have_content('bar')
        expect(page).to have_content("$1000.00")
      end
    end
  end

  describe 'show page' do
    context 'when user is not authenticated' do
      it 'redirects to sign-in' do
        investment_account = create(:investment_account)
        visit investment_account_path(investment_account)
        expect(page).to have_current_path('/users/sign_in')
      end
    end

    context 'when user is authenticated' do
      let!(:investment_account) { create(:investment_account, organization: user.organization) }

      before do
        sign_in user
      end

      it 'can not view another household investment account' do
        other_investment_account = create(:investment_account)
        visit investment_account_path(other_investment_account)
        expect(page).to have_content(I18n.t('views.default.flash.not_authorized'))
        expect(page).to have_current_path(investment_accounts_path)
      end

      it 'can delete an investment account' do
        investment_account_name = investment_account.name
        visit investment_account_path(investment_account)

        accept_confirm do
          click_button I18n.t('views.default.actions.delete')
        end

        expect(page).to have_content(I18n.t('views.investment_accounts.destroy.flash.success',
                                            name: investment_account_name))
      end

      context 'details' do
        it 'has a name and description' do
          visit investment_account_path(investment_account)
          expect(page).to have_content(investment_account.name)
          expect(page).to have_content(investment_account.description)
        end
        it 'has a contribution limit' do
          visit investment_account_path(investment_account)
          expect(page).to have_content("$#{Money.from_cents(investment_account.contribution_limit)}")
        end

        it 'has contributions' do
          visit investment_account_path(investment_account)
          expect(page).to have_content("$#{Money.from_cents(investment_account.total_contributions)}")
        end
      end
    end
  end
end
