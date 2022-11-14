# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def update?
    record.future?
  end
end
