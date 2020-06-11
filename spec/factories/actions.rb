# == Schema Information
#
# Table name: actions
#
#  id                :bigint           not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  mailtrain_list_id :string
#
FactoryBot.define do
  factory :action do
    name { "MyString" }
    mailtrain_list_id { "MyString" }
  end
end
