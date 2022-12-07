# frozen_string_literal: true

RSpec.describe 'Event Categories index' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }

    before do
      event_category

      get '/api/v1/event_categories', headers: { 'Auth-Token': user.auth_token }
    end

    it 'has successfull status' do
      expect(response).to have_http_status(:ok)
    end

    it 'includes event category in response' do
      expect(response.body).to include(event_category.name, event_category.id.to_s)
    end

    it { is_expected.to include_pagination(1, 20) }
  end

  it_behaves_like 'unauthenticated api request', :get, '/api/v1/event_categories'
end
