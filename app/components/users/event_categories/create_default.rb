# frozen_string_literal: true

module Users
  module EventCategories
    class CreateDefault < Base::Service
      attr_reader :user

      DEFAULT_EVENT_CATEGORIES_NAMES = %w[Личное Работа Отдых].freeze

      def initialize(user)
        @user = user
      end

      def call
        DEFAULT_EVENT_CATEGORIES_NAMES.each do |name|
          user.event_categories.create(name: name)
        end
      end
    end
  end
end
