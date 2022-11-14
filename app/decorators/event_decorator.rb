# frozen_string_literal: true

class EventDecorator < ApplicationDecorator
  delegate_all

  def formatted_date
    if object.whole_day_event?
      object.datetime.strftime('Число: %d-%m-%Y')
    else
      object.datetime.strftime('Число: %d-%m-%Y Время: %H:%M')
    end
  end
end
