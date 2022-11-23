# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'eventplanner@event.com'

  def notify(user, event)
    @event = event.decorate

    mail to: user.email, subject: "#{@event.name} приближается"
  end
end
