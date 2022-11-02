# frozen_string_literal: true

class CreateFirstNameAndLastNameInUsers < ActiveRecord::Migration[7.0]
  # rubocop: disable Rails/BulkChangeTable
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
  # rubocop: enable Rails/BulkChangeTable
end
