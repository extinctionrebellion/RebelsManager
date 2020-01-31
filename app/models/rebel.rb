# == Schema Information
#
# Table name: rebels
#
#  id                         :bigint           not null, primary key
#  active                     :boolean          default(TRUE)
#  agree_with_principles      :boolean
#  availability               :string
#  consent                    :boolean
#  email_bidx                 :string
#  email_ciphertext           :string
#  interests                  :string
#  internal_notes             :text
#  irl                        :boolean
#  language                   :string
#  lat                        :decimal(10, 6)
#  lon                        :decimal(10, 6)
#  name                       :string
#  notes                      :text
#  number_of_arrests          :integer
#  phone_bidx                 :string
#  phone_ciphertext           :string
#  postcode                   :string
#  regular_volunteer          :boolean          default(FALSE)
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

  encrypts :phone
  blind_index :phone

  encrypts :email
  blind_index :email

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

  # @TODO: Remove this lines after dropping email & phone columns
  self.ignored_columns = ['email', 'phone']
end
