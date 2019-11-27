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

class Skill < ApplicationRecord
  has_many :rebel_skills
  has_many :rebels, through: :rebel_skills

  validates :code, presence: true, uniqueness: {
    message: "This code has already been used, please use another."
  }
end
