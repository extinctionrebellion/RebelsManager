# == Schema Information
#
# Table name: local_groups
#
#  id                :bigint           not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  email             :string
#  mailtrain_list_id :string
#

require 'test_helper'

class LocalGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
