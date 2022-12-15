# frozen_string_literal: true

RSpec.describe 'Event Categories create' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:params) { { event_category: attributes } }
    let(:event_category) do
      post '/api/v1/event_categories', params: params, headers: { 'Auth-Token': user.auth_token }
    end

    before do
      allow(EventCategories::Create).to receive(:call).and_call_original
    end

    context 'with valid params' do
      let(:attributes) { { name: Faker::Lorem.sentence(word_count: 3), user: user } }

      it 'creates new event category' do
        expect { event_category }.to change(EventCategory, :count).by(1)
      end

      it 'has created status' do
        event_category

        expect(response).to have_http_status(:ok)
      end

      it 'includes created event category' do
        event_category

        expect(user.event_categories.last).to have_attributes(attributes)
      end
    end

    context 'with invalid params' do
      let(:attributes) { { name: '', user: user } }

      it 'not creates event category' do
        expect { event_category }.not_to change(EventCategory, :count)
      end

      it 'receives create service' do
        event_category

        expect(EventCategories::Create).to have_received(:call)
      end

      it { expect(event_category).to be_an_invalid_api_request("Name can't be blank") }
    end
  end

  it_behaves_like 'unauthenticated api request', :post, '/api/v1/event_categories'
end
