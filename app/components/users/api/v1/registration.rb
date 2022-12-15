# frozen_string_literal: true

module Users
  module Api
    module V1
      class Registration < Base::Service
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
          user = User.new(params)

          if user.save
            Users::EventCategories::CreateDefault.call(user)
            success(user)
          else
            fail!(user.errors.full_messages)
          end
        end
      end
    end
  end
end
