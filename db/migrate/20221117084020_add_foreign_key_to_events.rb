# frozen_string_literal: true

class AddForeignKeyToEvents < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :events, :event_categories, validate: false
  end
end
