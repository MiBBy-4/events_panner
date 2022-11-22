# frozen_string_literal: true

module Users
  class UsersController < AuthenticatedController
    def show
      @events_number = current_user.events.where(datetime: Time.zone.today..).count
      @today_events = current_user.events.where(datetime: Time.current...Time.zone.tomorrow).count
    end
  end
end
