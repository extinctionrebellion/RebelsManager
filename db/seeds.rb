# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.none?
  User.create(email: 'admin@example.com', password: 'admin123', admin: true)
end

if Rebel.none?
  local_group = LocalGroup.find_or_create_by(name: 'Example Group')

  5.times do
    Rebel.create(name: FFaker::Name.unique.name,
                 email: FFaker::Internet.unique.email,
                 consent: true,
                 language: 'en',
                 local_group: local_group)
  end
end
