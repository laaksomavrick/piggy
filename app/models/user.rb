# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :organization_memberships, dependent: :destroy
  has_many :organizations, through: :organization_memberships

  after_create :create_default_organization, if: :no_organization?

  validate :only_one_organization
  validates :first_name, :last_name, presence: true

  def membership
    organization.organization_memberships.where(user_id: id).first
  end

  def organization
    organizations.first
  end

  def organization_membership
    organization_memberships.first
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def only_one_organization
    return if organizations.count.zero? || (organizations.count == 1)

    errors.add(:organization, 'A user can only belong to one organization')
  end

  def create_default_organization
    default_organization = Organization.create(name: I18n.t('models.organization.fields.name.default'))
    OrganizationMembership.create(user_id: id, organization_id: default_organization.id, role: 'admin')
  end

  def no_organization?
    organizations.empty?
  end
end
