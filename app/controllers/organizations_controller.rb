# frozen_string_literal: true

class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  def show
    # TODO: authorization
    @organization = current_user.organization # TODO: this should be whatever is selected at the moment
  end
end
