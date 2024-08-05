# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships

  before_create :create_default_organization, if: :no_organization?

  def organization
    organizations.first # TODO: validate only one organization per user
  end

  private

  def create_default_organization
    default_organization = Organization.new(name: I18n.t('models.organization.fields.name.default'))
    organizations << default_organization
  end

  def no_organization?
    organizations.empty?
  end
end
