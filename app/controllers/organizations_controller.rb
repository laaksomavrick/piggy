# frozen_string_literal: true

class OrganizationsController < ApplicationController
  def index
    @organization = current_user.organization
  end
end
