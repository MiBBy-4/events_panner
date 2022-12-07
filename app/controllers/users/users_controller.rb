# frozen_string_literal: true

module Users
  class UsersController < AuthenticatedController
    def show
      @events_number = current_user.events.where(datetime: zone_scope.beginning_of_day..).count
      @today_events = current_user.events.where(datetime: zone_scope..zone_scope.end_of_day).count
    end

    private

    def zone_scope
      Time.find_zone(current_user.time_zone).now
    end
  end
end
