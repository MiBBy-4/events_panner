# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Api::V1::ApplicationController
        def create
          result = ::Users::Api::V1::Registration.call(registration_params)

          respond_with_resource(result, serializer: Api::V1::Users::Serializer)
        end

        private

        def registration_params
          params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :city,
                                       :time_zone)
        end
      end
    end
  end
end
