# frozen_string_literal: true

module Users
  module Api
    module V1
      class Session < Base::Service
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
          user = User.find_by!(email: params[:email])

          if user.valid_password?(params[:password])
            success(user)
          else
            fail!(ActiveRecord::RecordNotFound)
          end
        end
      end
    end
  end
end
