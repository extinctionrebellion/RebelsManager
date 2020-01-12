# == Schema Information
#
# Table name: rebels
#
#  id                         :bigint           not null, primary key
#  agree_with_principles      :boolean
#  availability               :string
#  consent                    :boolean
#  email_bidx                 :string
#  email_ciphertext           :string
#  interests                  :string
#  internal_notes             :text
#  irl                        :boolean
#  language                   :string
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

FactoryBot.define do
  factory :rebel do
    email { FFaker::Internet.safe_email }
    language { "en" }
    consent { true }
  end
end
