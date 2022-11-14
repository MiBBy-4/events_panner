# frozen_string_literal: true

RSpec.describe 'Event Category create' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event_category) { post event_categories_path, params: { event_category: attributes } }

    before { sign_in user }

    context 'with valid parameters' do
      let(:attributes) { { name: Faker::Lorem.sentence(word_count: 3), user: user } }

      it 'creates a new EventCategory' do
        expect { event_category }.to change(EventCategory, :count).by(1)
      end

      it { expect(event_category).to be_a_valid_request('/event_categories') }
    end

    context 'with invalid parameters' do
      let(:attributes) { { name: '', user: user } }

      it 'not creates a new EventCategory' do
        expect { event_category }.not_to change(EventCategory, :count)
      end

      it { expect(event_category).to be_an_invalid_request(:new) }
    end
  end

  it_behaves_like 'not authenticated', :post, '/event_categories'
end
