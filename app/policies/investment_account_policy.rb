# frozen_string_literal: true

class InvestmentAccountPolicy < ApplicationPolicy
  def show?
    @user.organization.id == @record.organization_id
  end
end
