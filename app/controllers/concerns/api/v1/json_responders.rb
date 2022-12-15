# frozen_string_literal: true

module Api
  module V1
    module JsonResponders
      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordNotFound, with: :respond_with_not_found
      end

      def respond_with_resource(result, serializer:, options: {})
        if result.success?
          respond_with_serialized_resource(result.value, serializer: serializer, options: options)
        else
          render_unprocessable_entity(result.error)
        end
      end

      def respond_with_serialized_resource(result, serializer:, options: {})
        render json: serializer.new(result, options: options).serializable_hash
      end

      def respond_with_collection(collection, serializer:, pagy:)
        render json: {
          data: collection,
          pagination: {
            page: pagy.page,
            per_page: pagy.items
          }
        }, each_serializer: serializer
      end

      def render_unprocessable_entity(errors)
        errors = [errors] unless errors.is_a?(Array)

        render json: { errors: errors }, status: :unprocessable_entity
      end

      def render_unauthenticated
        render json: 'You are unauthenticated', status: :unauthorized
      end

      def render_unauthorized
        render json: 'You are unauthorized', status: :unauthorized
      end

      def respond_with_not_found
        render json: { errors: 'Not Found' }, status: :not_found
      end
    end
  end
end
