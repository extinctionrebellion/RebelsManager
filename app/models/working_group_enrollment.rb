# == Schema Information
#
# Table name: working_group_enrollments
#
#  id               :bigint           not null, primary key
#  rebel_id         :bigint           not null
#  working_group_id :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class WorkingGroupEnrollment < ApplicationRecord
  belongs_to :rebel
  belongs_to :working_group
end
