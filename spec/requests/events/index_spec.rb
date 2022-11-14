# frozen_string_literal: true

RSpec.describe 'Events index' do
  context 'when authenticated' do
    let(:events) { create_list(:event, 1) }
    let(:user) { create(:user) }

    before do
      sign_in user
      get events_path
    end

    it 'assigns events' do
      expect(assigns(:events)).to eq(Event.all)
    end
  end

  it_behaves_like 'not authenticated', :get, '/events'
end
