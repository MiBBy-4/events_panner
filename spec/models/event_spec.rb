# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  datetime          :datetime         not null
#  description       :text
#  name              :string           not null
#  whole_day_event   :boolean          default(FALSE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  event_category_id :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_events_on_event_category_id  (event_category_id)
#  index_events_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_category_id => event_categories.id)
#  fk_rails_...  (user_id => users.id)
#

RSpec.describe Event do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event_category) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:datetime) }
  end

  describe '#past?' do
    let(:user) { create(:user) }
    let(:event_category) { create(:event_category, user: user) }

    context 'with not whole_day_event' do
      let(:event_in_past) do
        create(:event, datetime: '01.01.2000 12:00', whole_day_event: false, user: user, event_category: event_category)
      end
      let(:event_in_future) do
        create(:event, datetime: '31.12.2099 14:00', whole_day_event: false, user: user, event_category: event_category)
      end

      it 'returns true in past' do
        expect(event_in_past.past?).to be true
      end

      it 'returns false in future' do
        expect(event_in_future.past?).to be false
      end
    end

    context 'with whole_day_event' do
      let(:event_in_past) do
        create(:event, datetime: Time.zone.yesterday, whole_day_event: true, user: user, event_category: event_category)
      end
      let(:event_in_future) do
        create(:event, datetime: Time.zone.tomorrow, whole_day_event: true, user: user, event_category: event_category)
      end

      it 'returns true in past' do
        expect(event_in_past.past?).to be true
      end

      it 'returns false in future' do
        expect(event_in_future.past?).to be false
      end
    end
  end
end
