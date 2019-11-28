# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.none?
  # Admin user account
  User.create(email: 'admin@organise.earth', password: 'admin123', admin: true)
end

if Rebel.none?
  # Local groups
  local_group = LocalGroup.find_or_create_by(name: FFaker::Address.unique.city)
  local_group2 = LocalGroup.find_or_create_by(name: FFaker::Address.unique.city)

  # Local group coordinators user accounts
  User.create(
    email: 'local-group@organise.earth',
    password: 'admin123',
    local_group: local_group
  )
  User.create(
    email: 'local-group2@organise.earth',
    password: 'admin123',
    local_group: local_group2
  )

  # Working groups for both local groups
  WorkingGroup.create(local_group: local_group, name: 'Action & Strategy', color: '#16A938', code: 'ACT')
  WorkingGroup.create(local_group: local_group, name: 'Communication & IT', color: '#3760AA', code: 'CIT')
  WorkingGroup.create(local_group: local_group, name: 'Outreach', color: '#985C9B', code: 'OUT')
  WorkingGroup.create(local_group: local_group2, name: 'Action & Strategy', color: '#16A938', code: 'ACT')
  WorkingGroup.create(local_group: local_group2, name: 'Communication & IT', color: '#3760AA', code: 'CIT')
  WorkingGroup.create(local_group: local_group2, name: 'Outreach', color: '#985C9B', code: 'OUT')

  # Meaningful tags
  tags = ['', 'safe-list', 'xr-cafe', 'coordinator']

  # Rebel statuses
  statuses = ['active', 'paused', 'inactive']

  # Create rebels
  1254.times do
    rebel = Rebel.create(
      name: FFaker::Name.unique.name,
      email: FFaker::Internet.unique.email,
      consent: true,
      language: 'en',
      status: statuses.sample,
      tag_list: tags.sample,
      local_group: LocalGroup.order("RANDOM()").take,
      working_groups: WorkingGroup.limit(1).order("RANDOM()")
    )
  end
end
