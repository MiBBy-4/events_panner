# frozen_string_literal: true

module EventCategories
  class Destroy < Base::Service
    attr_reader :event_category

    def initialize(event_category)
      @event_category = event_category
    end

    def call
      if event_category.destroy
        success(event_category)
      else
        fail!(event_category.errors.full_messages)
      end
    end
  end
end
