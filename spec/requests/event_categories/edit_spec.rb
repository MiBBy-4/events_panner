# frozen_string_literal: true

RSpec.describe 'Event edit' do
  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }

  context 'when authenticated' do
    context 'when not authorized' do
      let(:another_user) { create(:user) }

      before do
        sign_in another_user
      end

      it 'returns NotFound' do
        expect { get edit_event_category_path(event_category) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when authorized' do
      before do
        sign_in user
        get edit_event_category_path(event_category)
      end

      it 'assigns event' do
        expect(assigns(:event_category)).to eq(event_category)
      end

      it 'includes name of event at the start of render' do
        expect(response.body).to include(event_category.name)
      end
    end
  end

  it_behaves_like 'not authenticated', :get, '/event_categories/1/edit'
end
