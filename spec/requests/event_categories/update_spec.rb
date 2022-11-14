# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event Category update' do
  let(:user) { create(:user) }
  let(:category) { create(:event_category, user: user) }
  let(:params) { { event_category: attributes } }

  context 'when authenticated' do
    before do
      sign_in user
      patch event_category_path(category), params: params
    end

    context 'with valid parameters' do
      let(:attributes) { { name: Faker::Lorem.sentence(word_count: 3) } }

      it 'updates event category' do
        expect(assigns(:event_category)).to eq(category)
      end

      it { is_expected.to be_a_valid_request('/event_categories') }
    end

    context 'with invalid parameters' do
      let(:attributes) { { name: '' } }

      it { is_expected.to be_an_invalid_request(:edit) }
    end
  end

  it_behaves_like 'not authenticated', :patch, '/event_categories/1'
end
