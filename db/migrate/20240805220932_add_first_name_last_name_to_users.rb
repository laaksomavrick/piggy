# frozen_string_literal: true

class AddFirstNameLastNameToUsers < ActiveRecord::Migration[7.1]
  def change
    # rubocop:disable Rails/BulkChangeTable
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''
    # rubocop:enable Rails/BulkChangeTable
  end
end
