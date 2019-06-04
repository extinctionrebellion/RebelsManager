# == Schema Information
#
# Table name: rebels
#
#  id             :bigint           not null, primary key
#  name           :string
#  email          :string
#  phone          :string
#  notes          :text
#  on_basecamp    :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  irl            :boolean
#  local_group_id :bigint
#

class Rebel < ApplicationRecord
  belongs_to :local_group

  has_many :working_group_enrollments
  has_many :working_groups, through: :working_group_enrollments

  validates :name,
            presence: { message: "Merci de préciser votre pseudo" }
  validates :email,
            presence: { message: "Merci de préciser votre adresse email" },
            uniqueness: { message: "Votre adresse email est déjà enregistrée" }
  validates :consent,
            inclusion: {
              in: [true],
              message: "Votre accord concernant l'usage de vos coordonnées est nécessaire"
            },
            on: :create

  def has_secure_email?
    email.include?("protonmail.")
  end
end
