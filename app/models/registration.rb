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
class Registration < ApplicationRecord
  belongs_to :action

  validates :name, presence: true
  validates :email, presence: true
end
