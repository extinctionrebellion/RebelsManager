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

require 'test_helper'

class WorkingGroupEnrollmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
