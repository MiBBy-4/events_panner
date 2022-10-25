# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def destroy
    super do
      return redirect_to new_user_session_path, status: :see_other
    end
  end
end
