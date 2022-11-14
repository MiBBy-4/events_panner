# frozen_string_literal: true

RSpec.shared_examples 'not authenticated' do |method, path|
  it 'returns a status of 302 and redirects' do
    public_send method, path

    expect(response).to have_http_status(:found).and redirect_to new_user_session_path
  end
end
