# == Schema Information
#
# Table name: registrations
#
#  id                      :bigint           not null, primary key
#  email                   :string
#  language                :string
#  name                    :string
#  participated_previously :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  action_id               :bigint           not null
#
FactoryBot.define do
  factory :registration do
    action { nil }
    name { "MyString" }
    email { "MyString" }
    participated_previously { false }
  end
end
