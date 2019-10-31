# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  email_bidx             :string
#  email_ciphertext       :string
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
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
end
