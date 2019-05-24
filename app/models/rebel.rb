# == Schema Information
#
# Table name: rebels
#
#  id             :bigint           not null, primary key
#  name           :string
#  email          :string
#  phone          :string
#  notes          :text
#  on_basecamp    :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  irl            :boolean
#  local_group_id :bigint
#

class Rebel < ApplicationRecord
  belongs_to :local_group

  has_many :working_group_enrollments
  has_many :working_groups, through: :working_group_enrollments

  validates :name,
            presence: true
  validates :email,
            presence: true,
            uniqueness: true

  def has_secure_email?
    email.include?("protonmail.")
  end
end
