# frozen_string_literal: true

RSpec.describe 'Event show' do
  include ActiveSupport::Testing::TimeHelpers

  let(:author) { create(:user) }
  let(:category) { create(:event_category, user: author) }
  let(:event) { create(:event, user: author, event_category: category) }

  before do
    travel_to Time.zone.local(2022, 11, 29)
  end

  context 'when authenticated' do
    context 'when not authorized' do
      let(:another_user) { create(:user) }

      before do
        get "/api/v1/events/#{event.id}", headers: { 'Auth-Token': another_user.auth_token }
      end

      it 'returns NotFound' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when authorized' do
      before do
        VCR.use_cassette('events/weather/receive_successfully') do
          get "/api/v1/events/#{event.id}", headers: { 'Auth-Token': author.auth_token }
        end
      end

      it 'has successfull status' do
        expect(response).to have_http_status(:ok)
      end

      it 'has weather description' do
        expect(response.body).to include('Погода на день')
      end
    end
  end

  it_behaves_like 'unauthenticated api request', :get, '/api/v1/events/1'
end
