# frozen_string_literal: true

RSpec.shared_examples 'unauthenticated api request' do |method, path|
  before do
    public_send method, path
  end

  it 'returns authenticated message' do
    expect(response.body).to eq('You are unauthenticated')
  end

  it 'returns unauthorized status' do
    expect(response).to have_http_status(:unauthorized)
  end
end
