usr = Role.create!(name: 'user')
adm = Role.create!(name: 'admin')

user1 = User.create!(
  first_name: 'Brandon',
  last_name: 'Smith',
  email: 'test1@test.com',
  phone_number: '123-456-789-1'
)

user2 = User.create!(
  first_name: 'Kyle',
  last_name: 'Tucker',
  email: 'test2@test.com',
  phone_number: '123-456-789-2'
)

Account.create!(
  user_id: user1.id,
  role_id: usr.id,
  username: 'bsmith876',
  password: 'Brandonsmithpw123!',
  last_login: '1/24/2024'
)

Account.create!(
  user_id: user2.id,
  role_id: adm.id,
  username: 'ktuck123',
  password: 'Ktuckpw123!',
  last_login: '1/24/2024'
)

puts "Seeded Successfully"