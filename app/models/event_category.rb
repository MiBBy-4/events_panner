# frozen_string_literal: true

# == Schema Information
#
# Table name: event_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_event_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class EventCategory < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :delete_all

  # rubocop: disable Rails/UniqueValidationWithoutIndex
  validates :name, presence: true, uniqueness: { scope: :user_id }
  # rubocop: enable Rails/UniqueValidationWithoutIndex
end
