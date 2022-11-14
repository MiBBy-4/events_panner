# frozen_string_literal: true

RSpec.describe EventPolicy, type: :policy do
  subject { described_class.new(user, event) }

  describe 'edit record' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }
    let(:event) do
      create(:event, name: Faker::Lorem.sentence, datetime: datetime, user: user, event_category: event_category)
    end

    context 'when in past' do
      let(:datetime) { Time.zone.yesterday }

      it { is_expected.to forbid_action(:edit) }
      it { is_expected.to forbid_action(:update) }
    end

    context 'when in future' do
      let(:datetime) { Time.zone.tomorrow }

      it { is_expected.to permit_action(:edit) }
      it { is_expected.to permit_action(:update) }
    end
  end

  describe 'update/create record' do
    let(:user) { create(:user) }
    let(:event) do
      create(:event, name: Faker::Lorem.sentence, datetime: Time.zone.tomorrow, user: user,
                     event_category: event_category)
    end

    context 'with current user category' do
      let(:event_category) { create(:event_category, user: user) }

      it { is_expected.to permit_action(:update) }
      it { is_expected.to permit_action(:create) }
    end

    context 'with not current user category' do
      let(:another_user) { create(:user) }
      let(:event_category) { create(:event_category, user: another_user) }

      it { is_expected.to forbid_action(:create) }
      it { is_expected.to forbid_action(:update) }
    end
  end
end
