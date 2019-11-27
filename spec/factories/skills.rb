FactoryBot.define do
  factory :skill do
    name { FFaker::Skill.specialty }
    code { rand(36**3).to_s(36).upcase }
  end
end
