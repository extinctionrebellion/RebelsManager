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
  local_group = LocalGroup.find_or_create_by(name: FFaker::Address.city)

  WorkingGroup.create(local_group: local_group, name: 'Action & Strategy', color: '#16A938')
  WorkingGroup.create(local_group: local_group, name: 'Communication & IT', color: '#3760AA')
  WorkingGroup.create(local_group: local_group, name: 'Outreach', color: '#985C9B')

  tags = ['', 'safe-list', 'xr-cafe', 'local-group-coordinator']

  20.times do
    rebel = Rebel.create(
      name: FFaker::Name.unique.name,
      email: FFaker::Internet.unique.email,
      consent: true,
      language: 'en',
      local_group: local_group,
      tag_list: tags.sample,
      working_groups: WorkingGroup.limit(1).order("RANDOM()")
    )
  end
end
