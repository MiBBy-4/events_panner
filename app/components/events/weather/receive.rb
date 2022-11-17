# frozen_string_literal: true

module Events
  module Weather
    class Receive < Base::Service
      WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/forecast'

      attr_reader :event

      def initialize(event)
        @event = event
      end

      def call
        weather = build_weather

        weather.presence || 'Информация недоступна'
      end

      private

      attr_accessor :response

      def build_weather
        response = load_weather

        return unless response.status.success?

        event_date = event.datetime.to_date
        weather = JSON.parse(response)['list'].find do |response_date|
          Time.zone.parse(response_date['dt_txt']).to_date == event_date
        end

        return if weather.blank?

        weather_string_for(weather)
      end

      def load_weather
        params = {
          q: event.city,
          appid: ENV.fetch('WEATHER_API_KEY', nil),
          units: 'metric',
          lang: 'ru'
        }

        HTTP.get(WEATHER_API_URL, params: params)
      end

      def weather_string_for(weather)
        temp_cont = weather['main']
        weather_cont = weather['weather'][0]

        "Погода на день: #{weather_cont['description']}, #{temp_cont['temp']}°C, ощущается: #{temp_cont['feels_like']}"
      end
    end
  end
end
