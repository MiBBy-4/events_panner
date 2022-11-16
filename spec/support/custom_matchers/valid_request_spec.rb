# frozen_string_literal: true

RSpec::Matchers.define :be_a_valid_request do |redirect_path|
  match do
    expect(response).to redirect_to redirect_path
    expect(flash[:success]).to be_present
  end
end
