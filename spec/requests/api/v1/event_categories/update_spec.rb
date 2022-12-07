# frozen_string_literal: true

RSpec.describe 'Event Categories update' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }
    let(:params) { { event_category: attributes } }

    before do
      allow(EventCategories::Update).to receive(:call).and_call_original

      patch "/api/v1/event_categories/#{event_category.id}", params: params,
                                                             headers: { 'Auth-Token': user.auth_token }
    end

    context 'with valid params' do
      let(:attributes) { { name: Faker::Lorem.sentence(word_count: 3) } }

      it 'has success status' do
        expect(response).to have_http_status(:ok)
      end

      it 'includes updated event category' do
        expect(user.event_categories.last).to have_attributes(attributes)
      end

      it 'receives update service' do
        expect(EventCategories::Update).to have_received(:call)
      end
    end

    context 'with invalid params' do
      let(:attributes) { { name: '' } }

      it { expect(event_category).to be_an_invalid_api_request("Name can't be blank") }
    end
  end

  it_behaves_like 'unauthenticated api request', :patch, '/api/v1/event_categories/1'
end
