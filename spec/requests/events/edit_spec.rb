# frozen_string_literal: true

RSpec.describe 'Event edit' do
  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }

  context 'when authenticated' do
    let(:event) { create(:event, user: user, datetime: datetime, event_category: event_category) }

    context 'when not authorized' do
      let(:another_user) { create(:user) }
      let(:datetime) { Time.zone.tomorrow }

      it 'returns NotFound' do
        sign_in another_user

        expect { get edit_event_path(event) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'with editable datetime' do
      let(:datetime) { Time.zone.tomorrow }

      before do
        sign_in user
        get edit_event_path(event)
      end

      it 'assigns event' do
        expect(assigns(:event)).to eq(event)
      end

      it 'includes name of event at the start of render' do
        expect(response.body).to include(event.name)
      end
    end

    context 'with not editable datetime' do
      let(:datetime) { Time.zone.yesterday }

      before do
        sign_in user
        get edit_event_path(event)
      end

      it 'returns a status of 302' do
        expect(response).to have_http_status(:found)
      end

      it 'redirect to root_path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  it_behaves_like 'not authenticated', :get, '/events/1/edit'
end
