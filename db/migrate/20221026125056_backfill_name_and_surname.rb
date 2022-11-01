# frozen_string_literal: true

class BackfillNameAndSurname < ActiveRecord::Migration[7.0]
  def change
    User.find_each do |user|
      user.first_name = user.name
      user.last_name = user.surname
      user.save
    end
  end
end
