# frozen_string_literal: true

class InvestmentAccount < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true
end
