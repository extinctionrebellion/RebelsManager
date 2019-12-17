# == Schema Information
#
# Table name: local_groups
#
#  id                :bigint           not null, primary key
#  email             :string
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  mailtrain_list_id :string
#

FactoryBot.define do
  factory :local_group do
    name { FFaker::Address.unique.city }
  end
end
