# frozen_string_literal: true

class AddWholeDayEventToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :whole_day_event, :boolean, null: false, default: false
  end
end
