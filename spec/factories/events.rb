# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  description    :text
#  ends_at        :datetime
#  facebook_url   :string
#  name           :string
#  slug           :string
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

    trait :past do
      starts_at { FFaker::Time.between(Time.now.beginning_of_day - 100.days, Time.now.beginning_of_day) }
      ends_at { starts_at - 2.hours }
    end

    trait :upcoming do
      starts_at { Time.now + 10.days }
      ends_at { Time.now + 10.days + 2.hours }
    end
  end
end
