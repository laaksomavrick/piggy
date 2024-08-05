# frozen_string_literal: true

class OrganizationMembership < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  SUPPORTED_ROLES = %w[
    member
    admin
  ].freeze

  validates :role, inclusion: {
    in: SUPPORTED_ROLES,
    message: '%<value>s is not a valid role'
  }
end
