# frozen_string_literal: true

class ValidateAddForeignKeyToEvents < ActiveRecord::Migration[7.0]
  def change
    validate_foreign_key :events, :event_categories
  end
end
