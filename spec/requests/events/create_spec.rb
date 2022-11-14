# frozen_string_literal: true

RSpec.describe 'Event create' do
  context 'when authentcated' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }
    let(:event) { post events_path, params: { event: attributes } }

    before { sign_in user }

    context 'with valid parameters' do
      let(:attributes) do
        { name: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, datetime: Time.zone.tomorrow, user: user,
          event_category_id: event_category.id }
      end

      it 'creates a new Event' do
        expect { event }.to change(Event, :count).by(1)
      end

      it { expect(event).to be_a_valid_request('/events') }
    end

    context 'with invalid parameters' do
      let(:attributes) do
        { description: Faker::Lorem.paragraph, datetime: Time.zone.tomorrow, user: user,
          event_category_id: event_category.id }
      end

      it 'creates a new Event' do
        expect { event }.not_to change(Event, :count)
      end

      it { expect(event).to be_an_invalid_request(:new) }
    end
  end

  it_behaves_like 'not authenticated', :post, '/events'
end
