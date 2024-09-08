# frozen_string_literal: true

class InvestmentAccount < ApplicationRecord
  belongs_to :organization
  has_many :transactions
  validates :name, presence: true

  scope :active, -> { where(is_deleted: false) }
  scope :deleted, -> { where(is_deleted: true) }

  def total_contributions
    transactions.sum(:amount)
  end
end
