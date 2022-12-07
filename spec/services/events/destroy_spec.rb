# frozen_string_literal: true

RSpec.describe Events::Destroy do
  subject(:instance) { described_class.new(event) }

  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }
  let(:event) { create(:event, datetime: Time.zone.tomorrow, user: user, event_category: event_category) }

  before do
    allow(Events::Notifications::Delete).to receive(:call).with(event).and_call_original

    instance.call
  end

  it 'receives Notification Delete service' do
    expect(Events::Notifications::Delete).to have_received(:call).once
  end

  it 'deletes event' do
    expect(instance.success?).to be true
  end
end
