# frozen_string_literal: true

module EventCategories
  class Update < Base::Service
    attr_reader :event_category, :params

    def initialize(event_category, params)
      @event_category = event_category
      @params = params
    end

    def call
      if event_category.update(params)
        success(event_category)
      else
        fail!(event_category.errors.full_messages)
      end
    end
  end
end
