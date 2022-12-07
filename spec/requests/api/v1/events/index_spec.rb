# frozen_string_literal: true

RSpec.describe 'Events' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }

    before do
      create(:event, name: 'First event', datetime: Time.zone.tomorrow, user: user, event_category: event_category)
      create(:event, name: 'Second event', datetime: Time.zone.tomorrow, user: user, event_category: event_category)

      get '/api/v1/events', headers: { 'Auth-Token': user.auth_token }
    end

    it 'returns number of all created events without limit' do
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it { is_expected.to include_pagination(1, 20) }

    it 'has successfull status' do
      expect(response).to have_http_status(:ok)
    end
  end

  it_behaves_like 'unauthenticated api request', :get, '/api/v1/events'
end
