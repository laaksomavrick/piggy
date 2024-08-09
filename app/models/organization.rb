# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships
  has_many :investment_accounts
end
