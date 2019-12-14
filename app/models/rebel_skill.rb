# == Schema Information
#
# Table name: rebel_skills
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rebel_id   :bigint           not null
#  skill_id   :bigint           not null
#

class RebelSkill < ApplicationRecord
  belongs_to :rebel
  belongs_to :skill
end
