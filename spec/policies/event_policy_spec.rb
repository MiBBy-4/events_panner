# frozen_string_literal: true

RSpec.describe EventPolicy, type: :policy do
  subject { described_class.new(user, event) }

  let(:user) { create(:user) }
  let(:event) { create(:event, name: Faker::Lorem.sentence, datetime: datetime, user: user) }

  describe 'edit record' do
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
end
