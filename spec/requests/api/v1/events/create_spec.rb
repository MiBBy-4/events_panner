# frozen_string_literal: true

RSpec.describe 'Event Create' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }
    let(:params) { { event: attributes } }
    let(:event) do
      post '/api/v1/events', params: params, headers: { 'Auth-Token': user.auth_token }
    end

    context 'with valid params' do
      let(:attributes) do
        {
          name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph,
          datetime: Time.find_zone(user.time_zone).parse(Time.zone.tomorrow.to_s),
          user: user, event_category_id: event_category.id
        }
      end

      it 'creates a new Event' do
        expect { event }.to change(Event, :count).by(1)
      end

      it 'has created status' do
        event

        expect(response).to have_http_status(:ok)
      end

      it 'creates an event' do
        event

        expect(user.events.last).to have_attributes(attributes)
      end
    end

    context 'with invalid params' do
      let(:attributes) { { name: nil, datetime: Time.zone.tomorrow, user: user, event_category_id: event_category.id } }

      it 'not creates event category' do
        expect { event }.not_to change(Event, :count)
      end

      it { expect(event).to be_an_invalid_api_request("Name can't be blank") }
    end
  end

  it_behaves_like 'unauthenticated api request', :post, '/api/v1/event_categories'
end
