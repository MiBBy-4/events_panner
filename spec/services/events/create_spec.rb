# frozen_string_literal: true

RSpec.describe Events::Create do
  subject(:instance) { described_class.new(event, params) }

  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }

  context 'with valid params' do
    let(:event) { build(:event, user: user, event_category: event_category, datetime: Time.zone.tomorrow) }
    let(:params) { { name: event.name, datetime: event.datetime, user: user, event_category: event_category } }

    before do
      allow(Events::TimeZone::Set).to receive(:call).with(event, params)
      allow(Events::Notifications::Create).to receive(:call).with(event).and_call_original

      instance.call
    end

    it 'receives TimeZone Set call' do
      expect(Events::TimeZone::Set).to have_received(:call).once
    end

    it 'receives notifications create service' do
      expect(Events::Notifications::Create).to have_received(:call).once
    end

    it 'has event as a value' do
      expect(instance.value).to eq(event)
    end

    it 'receives success method' do
      instance = described_class.new(event, params)
      allow(instance).to receive(:success).with(event)
      instance.call

      expect(instance).to have_received(:success).once
    end

    it 'saves event' do
      expect(instance.success?).to be true
    end
  end

  context 'with invalid params' do
    let(:event) { build(:event, name: '', user: user, event_category: event_category, datetime: Time.zone.tomorrow) }
    let(:params) { { name: event.name, datetime: event.datetime, user: user, event_category: event_category } }

    before do
      instance.call
    end

    it 'has error messages as error variable' do
      expect(instance.error).to eq(event.errors.full_messages)
    end
  end
end
