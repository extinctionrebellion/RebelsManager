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
  has_many :events

  validates :name,
            presence: { message: 'Please provide a name for the local group (eg. <em>Ibiza</em>)' },
            uniqueness: { message: 'A local group with this name has been found - Please provide another name' }

  scope :active, -> { where(active: true) }

  def destroyable_by?(user)
    user.admin? && !rebels.any?
  end
end
