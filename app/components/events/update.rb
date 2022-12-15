# frozen_string_literal: true

module Events
  class Update < Base::Service
    attr_reader :event, :params

    def initialize(event, params)
      @event = event
      @params = params
    end

    def call
      if event.update(params)
        update_timezone
      else
        fail!(event.errors.full_messages)
      end
    end

    private

    def update_timezone
      time_updater = Events::TimeZone::Update.call(event, params)

      if time_updater.success?
        reschedule_job

        success(event)
      else
        fail!(time_updater.error || notification_updater.error)
      end
    end

    def reschedule_job
      job = Sidekiq::ScheduledSet.new.find_job(event.remind_job_id)
      job&.reschedule(event.remind_at)
    end
  end
end
