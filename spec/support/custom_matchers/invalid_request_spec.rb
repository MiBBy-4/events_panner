# frozen_string_literal: true

RSpec::Matchers.define :be_an_invalid_request do |template|
  match do
    expect(response).to render_template(template)
    expect(flash[:danger]).to be_present
  end
end
