# frozen_string_literal: true

module Api
  module V1
    module Events
      class Serializer < ActiveModel::Serializer
        attributes :id, :name, :event_datetime, :event_remind_at, :description
        attribute :weather, if: :include_weather?

        belongs_to :event_category

        def event_datetime
          if object.whole_day_event?
            datetime_in_current_zone(object.datetime).strftime('%d-%m-%Y')
          else
            datetime_in_current_zone(object.datetime).strftime('%d-%m-%Y %H:%M')
          end
        end

        def event_remind_at
          datetime_in_current_zone(object.remind_at).strftime('%d-%m-%Y %H:%M') if object.remind_at.present?
        end

        def weather
          result = ::Events::Weather::Receive.call(object)

          if result.success?
            result.value
          else
            result.error
          end
        end

        def include_weather?
          @instance_options.dig(:options, :include_weather)
        end

        private

        def datetime_in_current_zone(date)
          user = object.user
          Time.find_zone(user.time_zone).parse(date.to_s)
        end
      end
    end
  end
end
