# == Schema Information
#
# Table name: registrations
#
#  id                      :bigint           not null, primary key
#  email                   :string
#  language                :string
#  name                    :string
#  participated_previously :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  action_id               :bigint           not null
#
require 'rails_helper'

RSpec.describe Registration, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
