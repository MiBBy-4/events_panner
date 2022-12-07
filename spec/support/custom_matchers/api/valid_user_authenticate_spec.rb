# frozen_string_literal: true

RSpec::Matchers.define :authenticate do |user|
  match do
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(user.email, user.auth_token)
  end
end
