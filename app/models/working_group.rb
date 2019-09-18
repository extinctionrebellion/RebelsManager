# == Schema Information
#
# Table name: working_groups
#
#  id             :bigint           not null, primary key
#  local_group_id :bigint           not null
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  color          :string
#

class WorkingGroup < ApplicationRecord
  belongs_to :local_group

  has_many :working_group_enrollments
  has_many :rebels, through: :working_group_enrollments
end