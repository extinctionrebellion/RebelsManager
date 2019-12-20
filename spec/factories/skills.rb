# == Schema Information
#
# Table name: skills
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :skill do
    name { FFaker::Skill.specialty }
    code { rand(36**3).to_s(36).upcase }
  end
end
