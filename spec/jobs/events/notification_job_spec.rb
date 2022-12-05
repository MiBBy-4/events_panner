# frozen_string_literal: true

RSpec.describe Events::NotificationJob do
  subject(:mailer) { described_class.new.perform(event.id) }

  let(:user) { create(:user) }
  let(:event_category) { create(:event_category, user: user) }
  let(:event) { create(:event, user: user, event_category: event_category, datetime: Time.zone.tomorrow) }

  it 'changes jobs size by 1' do
    expect { described_class.perform_at(event.datetime, event.id) }.to change { described_class.jobs.size }.by(1)
  end

  it 'sends mail to user' do
    expect(mailer.to.first).to eq(user.email)
  end

  it 'includes event name in a subject' do
    expect(mailer.subject).to include(event.name)
  end

  it 'changes deliveries size' do
    expect { mailer }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
