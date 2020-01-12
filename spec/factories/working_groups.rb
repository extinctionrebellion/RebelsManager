# == Schema Information
#
# Table name: working_groups
#
#  id             :bigint           not null, primary key
#  code           :string
#  color          :string
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  local_group_id :bigint           not null
#

FactoryBot.define do
  factory :working_group do
    local_group
    name { FFaker::Skill.specialty }
    code { rand(36**3).to_s(36).upcase }
  end
end
