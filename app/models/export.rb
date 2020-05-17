class Export < ApplicationRecord
  validates :export_type, presence: true
  validates :status, presence: true

  def downloadable?
    # exports are available for 2 days
    created_at >= (Time.now - 2.days)
  end

  def generated_by?(user_id)
    current_user.id == user_id
  end
end
