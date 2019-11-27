FactoryBot.define do
  factory :local_group do
    name { FFaker::Address.unique.city }
  end
end
