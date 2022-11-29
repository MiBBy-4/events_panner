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
        time_updater = Events::TimeZone::Update.call(event, params)

        if time_updater.success?
          job_scope&.reschedule(event.remind_at)
          success(event)
        else
          fail!(time_updater.error || notification_updater.error)
        end
      else
        fail!(event.errors.full_messages)
      end
    end

    private

    def job_scope
      Sidekiq::ScheduledSet.new.find_job(event.remind_job_id)
    end
  end
end
