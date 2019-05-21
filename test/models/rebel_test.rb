# == Schema Information
#
# Table name: rebels
#
#  id          :bigint           not null, primary key
#  name        :string
#  email       :string
#  phone       :string
#  notes       :text
#  on_basecamp :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  irl         :boolean
#

require 'test_helper'

class RebelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
