class Event < ApplicationRecord
  belongs_to :local_group, optional: true

  validates :name,
            presence: { message: 'Please provide a name for this event' }

  validates :description,
            presence: { message: 'Please provide a description for this event' }

  validates :start_at,
            presence: { message: 'Please provide a start date for this event' }

  validates :start_at,
            presence: { message: 'Please provide an end date for this event' }

end
