# frozen_string_literal: true

RSpec.describe 'Event update' do
  let(:user) { create(:user) }
  let(:category) { create(:event_category, user: user) }
  let(:event) { create(:event, datetime: Time.zone.tomorrow, event_category: category, user: user) }
  let(:params) { { event: attributes } }

  context 'when authenticated' do
    before do
      sign_in user

      patch event_path(event), params: params
    end

    context 'with valid parameters' do
      let(:attributes) { { name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph } }

      it 'updates event' do
        expect(assigns(:event)).to eq(event)
      end

      it { is_expected.to be_a_valid_request('/events') }
    end

    context 'with invalid parameters' do
      let(:attributes) { { name: '', description: Faker::Lorem.paragraph } }

      it { is_expected.to be_an_invalid_request(:edit) }
    end
  end

  it_behaves_like 'not authenticated', :patch, '/events/1'
end
