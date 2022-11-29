# frozen_string_literal: true

module Events
  module TimeZone
    class Set < Base::Service
      attr_reader :event, :params

      def initialize(event, params)
        @event = event
        @params = params
      end

      def call
        event.datetime = parse_date_in_current_timezone(params[:datetime])
        event.remind_at = parse_date_in_current_timezone(params[:remind_at]) if params[:remind_at].present?
      end

      private

      def parse_date_in_current_timezone(date)
        user = event.user
        Time.find_zone(user.time_zone).parse(date.to_s)
      end
    end
  end
end
