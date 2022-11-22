# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def destroy
      super do
        return redirect_to new_user_session_path, status: :see_other
      end
    end
  end
end
