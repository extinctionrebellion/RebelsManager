# == Schema Information
#
# Table name: working_groups
#
#  id             :bigint           not null, primary key
#  color          :string
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  local_group_id :bigint           not null
#

require 'test_helper'

class WorkingGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
