# == Schema Information
#
# Table name: skills
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Skill < ApplicationRecord
  has_many :rebel_skills
  has_many :rebels, through: :rebel_skills
end
