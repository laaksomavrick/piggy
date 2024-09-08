# frozen_string_literal: true

class CreateInvestmentAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :investment_accounts do |t|
      t.belongs_to :organization, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.bigint :contribution_limit
      t.timestamps
    end
  end
end
