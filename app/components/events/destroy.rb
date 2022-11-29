# frozen_string_literal: true

module Events
  class Destroy < Base::Service
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def call
      if event.destroy
        Events::Notifications::Delete.call(event)
      else
        fail!(event.errors.full_messages)
      end
    end
  end
end
