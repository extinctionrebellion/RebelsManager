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
#  failed_attempts        :integer          default("0"), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  otp_auth_secret        :string
#  otp_challenge_expires  :datetime
#  otp_enabled            :boolean          default("false"), not null
#  otp_enabled_on         :datetime
#  otp_failed_attempts    :integer          default("0"), not null
#  otp_mandatory          :boolean          default("false"), not null
#  otp_persistence_seed   :string
#  otp_recovery_counter   :integer          default("0"), not null
#  otp_recovery_secret    :string
#  otp_session_challenge  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  sign_in_count          :integer          default("0"), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  local_group_id         :bigint
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
