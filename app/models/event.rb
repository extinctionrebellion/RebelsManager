# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  description    :text
#  ends_at        :datetime
#  facebook_url   :string
#  name           :string
#  starts_at      :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  local_group_id :bigint
#

class Event < ApplicationRecord
  belongs_to :local_group, optional: true

  validates :name,
            presence: { message: 'Please provide a name for this event' }

  validates :description,
            presence: { message: 'Please provide a description for this event' }

  validates :starts_at_date,
            presence: { message: 'Please provide a start date for this event' }

  validates :ends_at_date,
            presence: { message: 'Please provide an end date for this event' }

  attr_accessor :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time

  def destroyable_by?(user)
    user.admin?
  end
end
