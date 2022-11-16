# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @events_number = current_user.events.where('datetime >= :today', today: Time.zone.today).count
    @today_events = current_user.events.where('datetime >= :now and datetime < :tomorrow',
                                              now: Time.current, tomorrow: Time.zone.tomorrow).count
  end
end
