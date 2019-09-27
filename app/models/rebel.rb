# == Schema Information
#
# Table name: rebels
#
#  id                         :bigint           not null, primary key
#  name                       :string
#  email                      :string
#  phone                      :string
#  notes                      :text
#  on_basecamp                :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  irl                        :boolean
#  local_group_id             :bigint
#  consent                    :boolean
#  tags                       :text
#  language                   :string
#  postcode                   :string
#  interests                  :string
#  internal_notes             :text
#  status                     :string
#  source                     :string
#  willingness_to_be_arrested :boolean
#  token                      :string
#  self_updated_at            :datetime
#

class Rebel < ApplicationRecord
  acts_as_taggable

  belongs_to :local_group, optional: true

  has_many :working_group_enrollments
  has_many :working_groups, through: :working_group_enrollments
  has_many :rebel_skills
  has_many :skills, through: :rebel_skills

  attr_accessor :redirect

  validates :email,
            presence: { message: _("Please provide an email address") },
            uniqueness: { message: _("This email address is already linked to a rebel") }
  validates :consent,
            inclusion: {
              in: [true],
              message: _("Your consent about data usage is required")
            },
            on: :create

  def has_secure_email?
    email.include?("protonmail.") || email.include?("tutanota.")
  end

  # Public profile url for this rebel
  def profile_url
    "#{ENV['APP_URL']}/public/rebels/#{id}/edit?a=#{created_at.to_i}&b=#{email}&c=#{token}"
  end
end
