# frozen_string_literal: true

module Api
  module V1
    module Authenticatable
      extend ActiveSupport::Concern

      included do
        def authenticate_user
          return if current_user.present?

          render_unauthorized
        end

        def current_user
          User.find_by(auth_token: auth_token)
        end

        private

        def auth_token
          request.headers['Auth-Token']
        end
      end
    end
  end
end
