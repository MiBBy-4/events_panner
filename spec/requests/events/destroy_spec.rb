# frozen_string_literal: true

RSpec.describe 'Event destroy' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event) { create(:event, user: user) }

    context 'when not authorized' do
      let(:another_user) { create(:user) }

      it 'returns NotFound' do
        sign_in another_user

        expect { delete event_path(event) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when authorized' do
      before do
        sign_in user

        delete event_path(event)
      end

      it { is_expected.to be_a_valid_request('/events') }
    end
  end

  it_behaves_like 'not authenticated', :delete, '/events/1'
end
