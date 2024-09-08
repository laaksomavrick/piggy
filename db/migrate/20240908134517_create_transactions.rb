# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :investment_account, null: false, foreign_key: true

      t.bigint :amount, null: false

      t.timestamps
    end
  end
end
