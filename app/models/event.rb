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
class Event < ApplicationRecord
  validates :name, presence: true
  validates :datetime, presence: true

  belongs_to :user
  belongs_to :event_category

  def future?
    !past?
  end

  def past?
    if whole_day_event?
      Time.zone.today > datetime
    else
      Time.current > datetime
    end
  end
end
