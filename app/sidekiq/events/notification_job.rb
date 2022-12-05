# frozen_string_literal: true

module Events
  class NotificationJob
    include Sidekiq::Job
    queue_as :event_notifications

    def perform(event_id)
      event = Event.find(event_id)
      user = event.user

      NotificationMailer.notify(user, event).deliver_now
    end
  end
end
