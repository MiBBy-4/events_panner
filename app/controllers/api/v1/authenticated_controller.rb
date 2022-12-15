# frozen_string_literal: true

module Api
  module V1
    class AuthenticatedController < Api::V1::ApplicationController
      before_action :authenticate_user

      include Api::V1::AuthenticatableUser
    end
  end
end
