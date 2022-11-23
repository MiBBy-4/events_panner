# frozen_string_literal: true

module Events
  module Notifications
    class Create < Base::Service
      attr_reader :event

      def initialize(event)
        @event = event
      end

      def call
        event.remind_job_id = Events::NotificationJob.perform_at(when_to_remind, event.id)
        event.save
      end

      private

      def when_to_remind
        event.remind_at || (event.datetime - 1.hour)
      end
    end
  end
end
