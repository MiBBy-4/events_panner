# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include DeviseAuthenticatable
end
