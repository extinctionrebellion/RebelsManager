# == Schema Information
#
# Table name: rebels
#
#  id                         :bigint           not null, primary key
#  availability               :string
#  consent                    :boolean
#  email                      :string
#  email_bidx                 :string
#  email_ciphertext           :string
#  interests                  :string
#  internal_notes             :text
#  irl                        :boolean
#  language                   :string
#  name                       :string
#  notes                      :text
#  number_of_arrests          :integer
#  phone                      :string
#  phone_bidx                 :string
#  phone_ciphertext           :string
#  postcode                   :string
#  self_updated_at            :datetime
#  source                     :string
#  status                     :string
#  tags                       :text
#  token                      :string
#  willingness_to_be_arrested :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  local_group_id             :bigint
#

class Rebel < ApplicationRecord
  acts_as_taggable

  belongs_to :local_group, optional: true

  has_many :working_group_enrollments, dependent: :destroy
  has_many :working_groups, through: :working_group_enrollments
  has_many :rebel_skills, dependent: :destroy
  has_many :skills, through: :rebel_skills

  encrypts :phone, migrating: true
  blind_index :phone, migrating: true

  encrypts :email, migrating: true
  blind_index :email, migrating: true

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
