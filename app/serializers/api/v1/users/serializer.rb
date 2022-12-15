# frozen_string_literal: true

module Api
  module V1
    module Users
      class Serializer < ActiveModel::Serializer
        attributes :id, :email, :auth_token, :first_name, :last_name, :city, :time_zone
      end
    end
  end
end
