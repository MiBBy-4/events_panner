# frozen_string_literal: true

class EventPolicy < ApplicationPolicy
  def update?
    record.future? && current_user_category?
  end

  def create?
    current_user_category?
  end

  private

  def current_user_category?
    user.event_categories.exists?(id: record.event_category_id)
  end
end
