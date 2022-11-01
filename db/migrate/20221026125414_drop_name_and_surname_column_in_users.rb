# frozen_string_literal: true

class DropNameAndSurnameColumnInUsers < ActiveRecord::Migration[7.0]
  def change
    safety_assured { remove_column :users, :name, :string }
    safety_assured { remove_column :users, :surname, :string }
  end
end
