# frozen_string_literal: true

module Events
  class Create < Base::Service
    attr_reader :event, :params

    def initialize(event, params)
      @event = event
      @params = params
    end

    def call
      Events::TimeZone::Set.call(event, params)

      if event.save
        set_notification
      else
        fail!(event.errors.full_messages)
      end
    end

    private

    def set_notification
      notificador = Events::Notifications::Create.call(event)

      if notificador.success?
        success(event)
      else
        fail!(notificador.error)
      end
    end
  end
end
