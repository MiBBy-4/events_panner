# frozen_string_literal: true

module Api
  module V1
    module Authorization
      extend ActiveSupport::Concern

      included do
        include Pundit::Authorization

        rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

        private

        def user_not_authorized
          render_unauthorized
        end
      end
    end
  end
end
