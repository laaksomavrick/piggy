# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @accounts = current_user.organization.investment_accounts
  end
end
