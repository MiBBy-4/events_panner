# frozen_string_literal: true

RSpec.describe 'Event Destroy' do
  context 'when authenticated' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }
    let(:event) { create(:event, user: user, event_category: event_category, remind_job_id: 'test') }

    context 'when not authorized' do
      let(:another_user) { create(:user) }

      before do
        delete "/api/v1/events/#{event.id}", headers: { 'Auth-Token': another_user.auth_token }
      end

      it 'returns NotFound' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when authorized' do
      before do
        allow(Events::Destroy).to receive(:call).with(event).and_call_original

        delete "/api/v1/events/#{event.id}", headers: { 'Auth-Token': user.auth_token }
      end

      it 'sucessfully deletes event' do
        expect(response).to have_http_status(:ok)
      end

      it 'receives destroy service' do
        expect(Events::Destroy).to have_received(:call)
      end
    end
  end

  it_behaves_like 'unauthenticated api request', :delete, '/api/v1/events/1'
end
