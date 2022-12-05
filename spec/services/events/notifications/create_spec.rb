# frozen_string_literal: true

RSpec.describe Events::Notifications::Create do
  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }
  let(:event) do
    create(:event, user: user, event_category: event_category, datetime: Time.zone.tomorrow,
                   remind_at: (Time.zone.tomorrow - 1.hour))
  end

  before do
    allow(Events::NotificationJob).to receive(:perform_at).with(event.remind_at, event.id)
  end

  it 'schedules notification job' do
    described_class.call(event)

    expect(Events::NotificationJob).to have_received(:perform_at).once
  end
end
