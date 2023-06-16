# == Schema Information
#
# Table name: local_groups
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  email             :string
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  mailtrain_list_id :string
#

require 'test_helper'

class LocalGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
