# frozen_string_literal: true

class InvestmentAccountsController < ApplicationController
  def index
    @accounts = current_user.organization.investment_accounts
  end

  def new
    @investment_account = InvestmentAccount.new
  end

  def create
    @investment_account = InvestmentAccount.new(investment_account_params)

    if @investment_account.save
      flash[:notice] = t('views.investment_accounts.create.flash.success', name: @investment_account.name)
      redirect_to investment_accounts_path
    else
      flash.now[:alert] = t('views.investment_accounts.create.flash.failure', name: @investment_account.name)
      render :new
    end
  end

  private

  def investment_account_params
    params.require(:investment_account).permit(:name, :description, :contribution_limit, :organization_id)
  end
end
