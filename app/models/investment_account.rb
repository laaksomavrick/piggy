# frozen_string_literal: true

class InvestmentAccount < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true

  scope :active, -> { where(is_deleted: false) }
  scope :deleted, -> { where(is_deleted: true) }
end
