# This is seed data for a test account on the Taper application

role_user = Role.create!(name: 'user')

user = User.create!(
  first_name: 'Bob the Test Bot',
  last_name: 'Testerman',
  email: 'bob_the_test_bot@bot_test.com',
  phone_number: '123-456-789',
)

account = Account.create!(
  user_id: user.id,
  role_id: role_user.id,
  username: 'bob_the_test_bot123',
  password: 'Password123!',
  created_at: 'Thur, 8 Aug 2024 12:00:00.000000000 UTC +00:00'
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

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '7.6',
  created_at: 'Mon, 26 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '8.1',
  created_at: 'Wed, 28 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '4.4',
  created_at: 'Thur, 29 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '16',
  percentage: '5.3',
  created_at: 'Fri, 30 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Seltzer',
  ounces: '12',
  percentage: '5',
  created_at: 'Fri, 30 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Spirit',
  ounces: '1',
  percentage: '40',
  created_at: 'Sat, 31 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Seltzer',
  ounces: '12',
  percentage: '8',
  created_at: 'Sat, 31 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '4.2',
  created_at: 'Sat, 31 Aug 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Spirit',
  ounces: '2',
  percentage: '40',
  created_at: 'Sun, 1 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '6',
  percentage: '4.2',
  created_at: 'Sun, 1 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '6.3',
  created_at: 'Tue, 3 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '7',
  created_at: 'Fri, 6 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '4.4',
  created_at: 'Sun, 8 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '7.6',
  created_at: 'Sun, 8 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '7.6',
  created_at: 'Thur, 12 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '5',
  percentage: '6.5',
  created_at: 'Fri, 13 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Spirit',
  ounces: '1.5',
  percentage: '40',
  created_at: 'Sat, 14 Sep 2024 12:00:00.000000000 UTC +00:00'
)

account.drinks.create!(
  drink_type: 'Beer',
  ounces: '12',
  percentage: '7.6',
  created_at: 'Sun, 15 Sep 2024 12:00:00.000000000 UTC +00:00'
)

puts "Seeded Successfully"