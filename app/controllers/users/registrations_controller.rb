# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # rubocop: disable Rails/LexicallyScopedActionFilter
    after_action :create_default, only: :create
    # rubocop: enable Rails/LexicallyScopedActionFilter

    def new
      super do
        @time_zones = ActiveSupport::TimeZone.all.sort
      end
    end

    private

    def create_default
      Users::EventCategories::CreateDefault.call(current_user)
    end
  end
end
