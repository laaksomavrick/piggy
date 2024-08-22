# frozen_string_literal: true

class InvestmentAccountPolicy < ApplicationPolicy
  def show?
    @user.organization.id == @record.organization_id
  end

  def update?
    belongs_to_org = @user.organization.id == @record.organization_id
    is_admin = @user.admin?
    belongs_to_org && is_admin
  end

  def destroy?
    update?
  end
end
