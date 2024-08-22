# frozen_string_literal: true

class InvestmentAccountsController < ApplicationController
  def index
    @accounts = current_user.organization.investment_accounts.active
  end

  def show
    @investment_account = InvestmentAccount.find(params[:id])
    authorize @investment_account
  rescue Pundit::NotAuthorizedError
    flash[:alert] = t('views.default.flash.not_authorized')
    redirect_to investment_accounts_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t('views.default.flash.not_found')
    redirect_to investment_accounts_path
  end

  def new
    @investment_account = InvestmentAccount.new
  end

  def edit
    @investment_account = InvestmentAccount.find(params[:id])
    authorize @investment_account
  rescue Pundit::NotAuthorizedError
    flash[:alert] = t('views.default.flash.not_authorized')
    redirect_to investment_accounts_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = t('views.default.flash.not_found')
    redirect_to investment_accounts_path
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

  def update
    investment_account_id = params[:id].to_i
    @investment_account = authorize InvestmentAccount.find_by(id: investment_account_id)
    if @investment_account.update(investment_account_params)
      flash[:notice] = t('views.investment_accounts.update.flash.success', name: @investment_account.name)
      redirect_to @investment_account
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    investment_account_id = params[:id].to_i
    @investment_account = authorize InvestmentAccount.find_by(id: investment_account_id)

    @investment_account.is_deleted = true
    @investment_account.deleted_at = DateTime.now.utc
    if @investment_account.save
      flash[:notice] = t('views.investment_accounts.destroy.flash.success', name: @investment_account.name)
      redirect_to investment_accounts_path
    else
      flash[:alert] = t('views.investment_accounts.destroy.flash.failure', name: @investment_account.name)
      render :show
    end
  rescue Pundit::NotAuthorizedError
    flash[:alert] = t('views.default.flash.not_authorized')
    redirect_to investment_account_path(@investment_account)
  end

  private

  def investment_account_params
    params.require(:investment_account).permit(:name, :description, :contribution_limit, :organization_id)
  end
end
