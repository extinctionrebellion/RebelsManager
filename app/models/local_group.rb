# == Schema Information
#
# Table name: local_groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#

class LocalGroup < ApplicationRecord
  has_many :rebels
  has_many :working_groups
end
