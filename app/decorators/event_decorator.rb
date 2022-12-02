# frozen_string_literal: true

class EventDecorator < ApplicationDecorator
  delegate_all

  def formatted_date
    if object.whole_day_event?
      datetime_in_current_zone(object.datetime).strftime('Дата: %d-%m-%Y')
    else
      datetime_in_current_zone(object.datetime).strftime('Дата: %d-%m-%Y %H:%M')
    end
  end

  private

  def datetime_in_current_zone(date)
    user = object.user
    Time.find_zone(user.time_zone).parse(date.to_s)
  end
end
