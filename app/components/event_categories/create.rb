# frozen_string_literal: true

module EventCategories
  class Create < Base::Service
    attr_reader :event_category

    def initialize(event_category)
      @event_category = event_category
    end

    def call
      if event_category.save
        success(event_category)
      else
        fail!(event_category.errors.full_messages)
      end
    end
  end
end
