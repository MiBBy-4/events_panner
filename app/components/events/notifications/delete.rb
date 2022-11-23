# frozen_string_literal: true

module Events
  module Notifications
    class Delete < Base::Service
      attr_reader :event

      def initialize(event)
        @event = event
      end

      def call
        job&.delete
      end

      private

      def job
        Sidekiq::ScheduledSet.new.find_job(event.remind_job_id)
      end
    end
  end
end
