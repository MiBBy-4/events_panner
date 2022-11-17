# frozen_string_literal: true

RSpec.describe 'Event show' do
  let(:author) { create(:user) }
  let(:category) { create(:event_category, user: author) }
  let(:event) { create(:event, user: author, event_category: category) }

  context 'when authenticated' do
    context 'when not authorized' do
      let(:another_user) { create(:user) }

      it 'returns NotFound' do
        sign_in another_user

        expect { get event_path(event) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when authorized' do
      before do
        sign_in author
        VCR.use_cassette('events/weather/receive_successfully') do
          get event_path(event)
        end
      end

      it 'assigns event' do
        expect(assigns(:event)).to eq(event)
      end

      it 'includes name on the page' do
        VCR.use_cassette('events/weather/receive_successfully') do
          expect(response.body).to include(event.name)
        end
      end
    end
  end

  it_behaves_like 'not authenticated', :get, '/events/1'
end
