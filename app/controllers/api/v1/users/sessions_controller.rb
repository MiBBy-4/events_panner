# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < Api::V1::ApplicationController
        def create
          result = ::Users::Api::V1::Session.call(session_params)

          respond_with_resource(result, serializer: Api::V1::Users::Serializer)
        end

        private

        def session_params
          params.require(:user).permit(:email, :password)
        end
      end
    end
  end
end
