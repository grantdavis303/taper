role_user = Role.create!(name: 'user')

user = User.create!(
  first_name: 'Testly',
  last_name: 'Testerman',
  email: 'test@test.com',
  phone_number: '0123456789',
)

account = Account.create!(
  user_id: user.id,
  role_id: role_user.id,
  username: 'testuser1',
  password: 'Password123!',
  last_login: 'Does not matter',
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '8.1',
  created_at: 'Thur, 8 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '8',
  created_at: 'Thur, 8 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '7.2',
  created_at: 'Fri, 9 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '6.5',
  created_at: 'Fri, 9 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Wine',
  ounces: '12.7',
  percentage: '13.5',
  created_at: 'Sun, 11 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '7',
  created_at: 'Sun, 11 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '6.95',
  created_at: 'Wed, 14 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '8',
  created_at: 'Fri, 16 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '7.3',
  created_at: 'Fri, 16 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '5',
  created_at: 'Fri, 16 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '8',
  created_at: 'Sun, 18 Aug 2024 18:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '5',
  created_at: 'Sun, 18 Aug 2024 18:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Spirit',
  ounces: '2',
  percentage: '40',
  created_at: 'Sun, 18 Aug 2024 18:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '5',
  created_at: 'Tue, 20 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '7.3',
  created_at: 'Wed, 21 Aug 2024 18:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '6',
  percentage: '8',
  created_at: 'Wed, 21 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '7.6',
  created_at: 'Thur, 22 Aug 2024 12:00:00.000000000 UTC +00:00'
)

puts "Seeded Successfully"