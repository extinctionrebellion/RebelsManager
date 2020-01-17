FactoryBot.define do
  factory :user do
    email { FFaker::Internet.safe_email }

    trait :local_coordinator do
      local_group
    end
  end
end
