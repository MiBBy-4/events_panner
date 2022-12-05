# frozen_string_literal: true

class AddJidToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :remind_job_id, :string
  end
end
