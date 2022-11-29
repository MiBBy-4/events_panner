# frozen_string_literal: true

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:time_zone) }

    it do
      is_expected.to validate_inclusion_of(:time_zone)
        .in_array(ActiveSupport::TimeZone.all.map(&:name))
        .with_message('Timezone is not valid')
    end
  end
end
