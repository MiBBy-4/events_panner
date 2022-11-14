# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :authenticate_user!

  include DeviseAuthenticatable
  include Authorization
end
