# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def index
    @organization = current_user.organization
    @members = @organization.users.includes(:organization_memberships)
  end
end
