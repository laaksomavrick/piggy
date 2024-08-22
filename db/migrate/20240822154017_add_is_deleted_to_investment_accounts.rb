# frozen_string_literal: true

class AddIsDeletedToInvestmentAccounts < ActiveRecord::Migration[7.1]
  def change
    # rubocop:disable Rails/BulkChangeTable
    add_column :investment_accounts, :is_deleted, :boolean, default: false, null: false
    # rubocop:enable Rails/BulkChangeTable
    add_column :investment_accounts, :deleted_at, :datetime
  end
end
