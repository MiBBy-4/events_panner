# frozen_string_literal: true

RSpec.describe Events::Update do
  subject(:instance) { described_class.new(event, params) }

  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }
  let(:event) { create(:event, datetime: Time.zone.tomorrow, user: user, event_category: event_category) }

  context 'with valid params' do
    let(:params) { { name: Faker::Lorem.sentence, datetime: Time.zone.tomorrow } }

    before do
      allow(Events::TimeZone::Update).to receive(:call).with(event, params).and_call_original

      instance.call
    end

    it 'receives TimeZone update call' do
      expect(Events::TimeZone::Update).to have_received(:call).once
    end

    it 'updates name' do
      expect(event.name).to eq(params[:name])
    end

    it 'updates datetime' do
      expect(event.datetime).to eq(Time.find_zone(user.time_zone).parse(params[:datetime].to_s))
    end
  end

  context 'with invalid params' do
    let(:params) { { name: '' } }

    it 'has error messages as error variable' do
      instance.call

      expect(instance.error).to eq(event.errors.full_messages)
    end
  end
end
