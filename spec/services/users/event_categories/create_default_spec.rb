# frozen_string_literal: true

RSpec.describe Users::EventCategories::CreateDefault do
  let(:user) { create(:user) }

  describe '#call' do
    it 'returns null records before call' do
      expect(user.event_categories.count).to eq(0)
    end

    it 'returns 3 records after call' do
      described_class.call(user)
      expect(user.event_categories.count).to eq(3)
    end
  end
end
