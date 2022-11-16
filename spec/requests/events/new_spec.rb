# frozen_string_literal: true

RSpec.describe 'Event new' do
  context 'when authenticated' do
    let(:user) { create(:user) }

    before do
      sign_in user
      get new_event_path
    end

    it 'renders template' do
      expect(response).to render_template(:new)
    end
  end

  it_behaves_like 'not authenticated', :get, '/events/new'
end
