# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  description    :text
#  ends_at        :datetime
#  facebook_url   :string
#  name           :string
#  starts_at      :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  local_group_id :bigint
#

FactoryBot.define do
  factory :event do
    local_group
    name { FFaker::Skill.specialty }
    description { 'That\'s a super cool description' }
    starts_at_date { '19/12/2020' }
    ends_at_date { '21/12/2020' }
    facebook_url { 'https://facebook.com' }
  end
end
