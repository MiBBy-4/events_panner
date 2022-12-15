# frozen_string_literal: true

module Api
  module V1
    class EventCategoriesController < Api::V1::AuthenticatedController
      before_action :load_event_category, only: %i[update destroy]

      def index
        pagy, event_categories = pagy(event_category_scope)

        respond_with_collection(event_categories, serializer: Api::V1::EventCategories::Serializer, pagy: pagy)
      end

      def create
        event_category = event_category_scope.build(event_category_params)

        result = ::EventCategories::Create.call(event_category)

        respond_with_resource(result, serializer: Api::V1::EventCategories::Serializer)
      end

      def update
        result = ::EventCategories::Update.call(@event_category, event_category_params)

        respond_with_resource(result, serializer: Api::V1::EventCategories::Serializer)
      end

      def destroy
        result = ::EventCategories::Destroy.call(@event_category)

        respond_with_resource(result, serializer: Api::V1::EventCategories::Serializer)
      end

      private

      def event_category_scope
        current_user.event_categories
      end

      def event_category_params
        params.require(:event_category).permit(:name)
      end

      def load_event_category
        @event_category = event_category_scope.find(params[:id])
      end
    end
  end
end
