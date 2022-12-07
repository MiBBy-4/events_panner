# frozen_string_literal: true

module Api
  module V1
    module EventCategories
      class Serializer < ActiveModel::Serializer
        attributes :id, :name
      end
    end
  end
end
