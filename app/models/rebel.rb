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
#  consent        :boolean
#  tags           :text
#  language       :string
#  postcode       :string
#  interests      :string
#  internal_notes :text
#  status         :string
#

class Rebel < ApplicationRecord
  acts_as_taggable

  belongs_to :local_group, optional: true

  has_many :working_group_enrollments
  has_many :working_groups, through: :working_group_enrollments

  attr_accessor :redirect

  validates :name,
            presence: { message: "Please provide a name or nickname" }
  validates :email,
            presence: { message: "Please provide an email address" },
            uniqueness: { message: "This email address is already linked to a rebel" }
  validates :consent,
            inclusion: {
              in: [true],
              message: "Your consent about data usage is required"
            },
            on: :create

  def has_secure_email?
    email.include?("protonmail.") || email.include?("tutanota.")
  end
end
