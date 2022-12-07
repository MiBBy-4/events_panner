# frozen_string_literal: true

module Api
  module V1
    class EventsController < Api::V1::AuthenticatedController
      before_action :load_event, only: %i[update show destroy]

      def index
        pagy, events = pagy(event_scope)

        respond_with_collection(events, serializer: Api::V1::Events::Serializer, pagy: pagy)
      end

      def show
        respond_with_serialized_resource(@event, serializer: Api::V1::Events::Serializer,
                                                 options: { include_weather: true })
      end

      def create
        @event = event_scope.build(event_params)
        authorize(@event)

        creater = ::Events::Create.call(@event, event_params)

        respond_with_resource(creater, serializer: Api::V1::Events::Serializer)
      end

      def update
        authorize(@event)

        updater = ::Events::Update.call(@event, event_params)

        respond_with_resource(updater, serializer: Api::V1::Events::Serializer)
      end

      def destroy
        destroyer = ::Events::Destroy.call(@event)

        respond_with_resource(destroyer, serializer: Api::V1::Events::Serializer)
      end

      private

      def event_scope
        current_user.events
      end

      def event_params
        params.require(:event).permit(:name, :description, :datetime, :event_category_id, :whole_day_event, :city,
                                      :remind_at)
      end

      def load_event
        @event = event_scope.find(params[:id])
      end
    end
  end
end
