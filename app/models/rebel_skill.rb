# == Schema Information
#
# Table name: rebel_skills
#
#  id         :bigint           not null, primary key
#  rebel_id   :bigint           not null
#  skill_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RebelSkill < ApplicationRecord
  belongs_to :rebel
  belongs_to :skill
end
