# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ActionController::API
      include Api::V1::JsonResponders
    end
  end
end