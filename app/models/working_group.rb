class WorkingGroup < ApplicationRecord
  belongs_to :local_group

  has_many :working_group_enrollments
  has_many :rebels, through: :working_group_enrollments
end
