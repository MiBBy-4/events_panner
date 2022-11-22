# frozen_string_literal: true

RSpec.describe 'Event Category destroy' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }

    context 'when not authorized' do
      let(:another_user) { create(:user) }

      it 'returns NotFound' do
        sign_in another_user

        expect { delete event_category_path(event_category) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when authorized' do
      before do
        sign_in user

        delete event_category_path(event_category)
      end

      it { is_expected.to be_a_valid_request('/event_categories') }
    end
  end

  it_behaves_like 'not authenticated', :delete, '/event_categories/1'
end
