FactoryBot.define do
  factory :working_group do
    local_group
    name { FFaker::Skill.specialty }
    code { rand(36**3).to_s(36).upcase }
  end
end
