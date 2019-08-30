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

class LocalGroup < ApplicationRecord
  has_many :rebels
  has_many :working_groups

  def destroyable_by?(user)
    user.admin? && !rebels.any?
  end

  def has_basecamp?
    name == "Namur"
  end
end
