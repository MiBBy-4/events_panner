# frozen_string_literal: true

module Events
  module TimeZone
    class Update < Base::Service
      attr_reader :event, :params

      def initialize(event, params)
        @event = event
        @params = params
      end

      def call
        event.datetime = parse_date_in_current_timezone(params[:datetime]) if params[:datetetime].present?
        event.remind_at = parse_date_in_current_timezone(params[:remind_at]) if params[:remind_at].present?

        if event.save
          success(event)
        else
          fail!(event.errors.full_messages)
        end
      end

      private

      def parse_date_in_current_timezone(date)
        user = event.user
        Time.find_zone(user.time_zone).parse(date.to_s)
      end
    end
  end
end
