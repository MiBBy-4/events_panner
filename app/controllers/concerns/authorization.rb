# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      flash[:danger] = 'Вы не можете выполнить данное действие'
      redirect_back_or_to root_path
    end
  end
end
