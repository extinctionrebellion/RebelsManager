# == Schema Information
#
# Table name: rebels
#
#  id          :bigint           not null, primary key
#  name        :string
#  email       :string
#  phone       :string
#  notes       :text
#  on_basecamp :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Rebel < ApplicationRecord
  validates :name,
            presence: true
  validates :email,
            presence: true,
            uniqueness: true
end
