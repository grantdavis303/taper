user = Role.create!(name: 'user')
admin = Role.create!(name: 'admin')

user1 = User.create!(
  first_name: 'Grant',
  last_name: 'Davis',
  email: 'test@test.com',
  phone_number: '1234567890',
)

account1 = Account.create!(
  user_id: user1.id,
  role_id: user.id,
  username: 'testuser1',
  password: 'Password123!',
  last_login: 'Does not matter',
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '8.1'
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '8'
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '7.2'
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '6.5'
)

account1.drinks.create!(
  drink_type: 'Wine',
  ounces: '12.7',
  percentage: '13.5'
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '7'
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '6.95'
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '8'
)

account1.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '7.3'
)

puts "Seeded Successfully"