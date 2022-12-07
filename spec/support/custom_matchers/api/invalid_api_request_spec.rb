# frozen_string_literal: true

RSpec::Matchers.define :be_an_invalid_api_request do |error|
  match do
    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to include(error)
  end
end
