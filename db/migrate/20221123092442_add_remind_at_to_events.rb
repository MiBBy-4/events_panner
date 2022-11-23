# frozen_string_literal: true

class AddRemindAtToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :remind_at, :datetime
  end
end
