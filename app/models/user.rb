# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email_bidx             :string
#  email_ciphertext       :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  otp_auth_secret        :string
#  otp_challenge_expires  :datetime
#  otp_enabled            :boolean          default(FALSE), not null
#  otp_enabled_on         :datetime
#  otp_failed_attempts    :integer          default(0), not null
#  otp_mandatory          :boolean          default(FALSE), not null
#  otp_persistence_seed   :string
#  otp_recovery_counter   :integer          default(0), not null
#  otp_recovery_secret    :string
#  otp_session_challenge  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  local_group_id         :bigint
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :two_factorable, :database_authenticatable, :recoverable,
         :lockable, :trackable, :timeoutable

  encrypts :email
  blind_index :email

  belongs_to :local_group, optional: true

  # callbacks
  before_save :enable_2fa_if_admin

  def enable_2fa_if_admin
    self.otp_mandatory = true if admin == true
  end

  # @TODO: Remove this line after dropping email column
  self.ignored_columns = ['email']

  def ringer?
    role == "ringer"
  end
end
