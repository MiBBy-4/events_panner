# frozen_string_literal: true

class AddReferencesToEvents < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    # rubocop: disable Rails/NotNullColumn
    add_reference :events, :event_category, null: false, index: { algorithm: :concurrently }
    # rubocop: enable Rails/NotNullColumn
  end
end
