# frozen_string_literal: true

RSpec::Matchers.define :include_pagination do |page, per_page|
  match do
    expect(response.body).to include('pagination')
    expect(JSON.parse(response.body)['pagination']['page']).to eq(page)
    expect(JSON.parse(response.body)['pagination']['per_page']).to eq(per_page)
  end
end
