# == Schema Information
#
# Table name: local_groups
#
#  id                 :bigint           not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  email              :string
#  mailtrain_list_id  :string
#  welcome_email_body :text
#

class LocalGroup < ApplicationRecord
  has_many :rebels
  has_many :working_groups
  has_rich_text :welcome_email_body

  validates :name,
            presence: { message: "Please provide a name for the local group (eg. <em>Ibiza</em>)" },
            uniqueness: { message: "A local group with this name has been found - Please provide another name" }

  def destroyable_by?(user)
    user.admin? && !rebels.any?
  end

  def has_basecamp?
    name == "Namur" or name == "Liège"
  end
end
