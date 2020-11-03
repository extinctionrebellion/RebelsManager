class Export < ApplicationRecord
  belongs_to :user

  validates :export_type, presence: true

  def downloadable?
    # exports are available for 2 days
    created_at >= (Time.now - 2.days)
  end
end
