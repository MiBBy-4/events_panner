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
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :event do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    datetime { Time.current }
    user { User.last }
    event_category_id { 1 }
  end
end
