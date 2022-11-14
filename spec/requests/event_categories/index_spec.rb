# frozen_string_literal: true

RSpec.describe 'Event Categories index' do
  context 'when authenticated' do
    let(:event_categories) { create_list(:categories, 20) }
    let(:user) { create(:user) }

    before do
      sign_in user
      get event_categories_path
    end

    it 'assigns events' do
      expect(assigns(:event_categories)).to eq(EventCategory.all)
    end
  end

  it_behaves_like 'not authenticated', :get, '/event_categories'
end
