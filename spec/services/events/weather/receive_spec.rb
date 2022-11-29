# frozen_string_literal: true

RSpec.describe Events::Weather::Receive do
  include ActiveSupport::Testing::TimeHelpers

  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }
  let(:event) { create(:event, datetime: datetime, city: city, user: user, event_category: event_category) }

  before do
    travel_to Time.zone.local(2022, 11, 29)
  end

  context 'with valid params' do
    let(:datetime) { 1.day.from_now }
    let(:city) { 'Hrodna' }

    it 'returns succefull as a hash' do
      VCR.use_cassette('events/weather/receive_successfully') do
        receiver = described_class.call(event)

        expect(receiver.value).to be_an_instance_of(String).and match(/Погода на день/)
      end
    end
  end

  context 'with invalid params' do
    context 'with datetime more than 5 days from now' do
      let(:datetime) { 6.days.from_now }
      let(:city) { 'Hrodna' }

      it 'returns message as a text' do
        VCR.use_cassette('events/weather/receive_incorrect_date') do
          receiver = described_class.call(event)

          expect(receiver.value).to be_an_instance_of(String).and eq('Информация недоступна')
        end
      end
    end

    context 'without city' do
      let(:datetime) { Time.zone.tomorrow }
      let(:city) { nil }

      it 'returns message as a text' do
        VCR.use_cassette('events/weather/receive_without_city') do
          receiver = described_class.call(event)

          expect(receiver.value).to be_an_instance_of(String).and eq('Информация недоступна')
        end
      end
    end
  end
end
