# frozen_string_literal: true

RSpec.describe Events::TimeZone::Set do
  let(:user) { create(:user, time_zone: 'Minsk') }
  let(:event_category) { create(:event_category, user: user) }
  let(:event) { build(:event, datetime: '14.12.2022 14:00', user: user, event_category: event_category) }
  let(:params) { { datetime: '14.12.2022 14:00', remind_at: '14.12.2022 10:00' } }
  let(:local_date) { Time.find_zone(user.time_zone).parse(params[:datetime]) }

  before do
    described_class.call(event, params)
    event.save
  end

  it 'saves correct date in database' do
    expect(event.datetime).to eq(Time.find_zone('UTC').parse(local_date.to_s))
  end
end
