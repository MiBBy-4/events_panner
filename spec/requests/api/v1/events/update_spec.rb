# frozen_string_literal: true

RSpec.describe 'Update Event' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:category) { create(:event_category, user: user) }
    let(:event) { create(:event, datetime: Time.zone.tomorrow, event_category: category, user: user) }
    let(:params) { { event: attributes } }

    before do
      allow(Sidekiq::ScheduledSet.new).to receive(:find_job).and_call_original
      allow(Events::Update).to receive(:call).and_call_original

      patch "/api/v1/events/#{event.id}", params: params,
                                          headers: { 'Auth-Token': user.auth_token }
    end

    context 'with valid params' do
      let(:attributes) { { name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph } }

      it 'has success status' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates an event' do
        expect(user.events.last).to have_attributes(attributes)
      end

      it 'receives update service' do
        expect(Events::Update).to have_received(:call)
      end
    end

    context 'with invalid params' do
      let(:attributes) { { name: '', description: Faker::Lorem.paragraph } }

      it { expect(event).to be_an_invalid_api_request("Name can't be blank") }
    end
  end

  it_behaves_like 'unauthenticated api request', :patch, '/api/v1/events/1'
end
