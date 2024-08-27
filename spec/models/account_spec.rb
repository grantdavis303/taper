require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:role) }
  end

  describe 'validations' do
    subject { 
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test_account@test.com', phone_number: '123-456-7890')
      role = Role.create!(name: 'user')
      Account.new(user_id: user.id, role_id: role.id, username: 'testuser', password: 'Testpassword1!', last_login: 'today')
    }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:role_id) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:last_login) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_numericality_of(:role_id) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should validate_length_of(:password).is_at_most(64) }
    it { should have_secure_password }
  end

  describe 'custom validations' do
    it 'validate valid_password' do
      role = Role.create!(name: 'user')
      user1 = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      user2 = User.create!(first_name: 'test', last_name: 'test', email: 'test2@test.com', phone_number: '122-456-7892')
      user3 = User.create!(first_name: 'test', last_name: 'test', email: 'test3@test.com', phone_number: '123-456-7893')
      user4 = User.create!(first_name: 'test', last_name: 'test', email: 'test4@test.com', phone_number: '124-456-7894')
      user5 = User.create!(first_name: 'test', last_name: 'test', email: 'test5@test.com', phone_number: '125-456-7895')
      account1 = Account.new(user_id: user1.id, role_id: role.id, username: 'testuser1', password: '', last_login: 'today')
      account2 = Account.new(user_id: user2.id, role_id: role.id, username: 'testuser2', password: 'testtest', last_login: 'today')
      account3 = Account.new(user_id: user3.id, role_id: role.id, username: 'testuser3', password: 'testtest1', last_login: 'today')
      account4 = Account.new(user_id: user4.id, role_id: role.id, username: 'testuser4', password: 'testtest1!', last_login: 'today')
      account5 = Account.new(user_id: user5.id, role_id: role.id, username: 'testuser5', password: 'Testtest1!', last_login: 'today')
      expect(account1.valid?).to eq (false)
      expect(account2.valid?).to eq (false)
      expect(account3.valid?).to eq (false)
      expect(account4.valid?).to eq (false)
      expect(account5.valid?).to eq (true)
    end
  end

  describe 'instance methods' do
    it '#all_drinks_in_reverse_order' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      drink1 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      drink2 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      drink3 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.all_drinks_in_reverse_order).to eq ([drink3, drink2, drink1])
    end

    it '#drink_units_today' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 1)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_today).to eq (3.19)
    end

    it '#drink_count_today' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_today).to eq (3)
    end

    it '#drink_units_this_week' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 7)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_this_week).to eq (3.19)
    end

    it '#drink_count_this_week' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 7)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_this_week).to eq (2)
    end

    it '#drink_units_this_year' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 365)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_this_year).to eq (3.19)
    end

    it '#drink_count_this_year' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 365)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_this_year).to eq (2)
    end

    it '#drink_units_all_time' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_all_time).to eq (4.25)
    end

    it '#drink_count_all_time' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_all_time).to eq (3)
    end

    it '#drink_units_specific(start_date, end_date)' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 14)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4', created_at: Date.today - 10)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5', created_at: Date.today - 6)
      start_date = Date.today - 11
      end_date = Date.today - 2
      expect(account.drink_units_specific(start_date, end_date)).to eq (3.19)
    end

    it '#drink_count_specific(start_date, end_date)' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 14)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4', created_at: Date.today - 10)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5', created_at: Date.today - 6)
      start_date = Date.today - 11
      end_date = Date.today - 2
      expect(account.drink_count_specific(start_date, end_date)).to eq (2)
    end

    it '#weeks_this_year' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.weeks_this_year).to eq (Date.today.cweek)
    end

    it '#weeks_status_count(status_type)' do # might cause some errors at beginning of new year
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5', created_at: Date.today - 7)
      account.drinks.create!(drink_type: 'Beer', ounces: '20', percentage: '12', created_at: Date.today - 14)
      account.drinks.create!(drink_type: 'Beer', ounces: '20', percentage: '30', created_at: Date.today - 21)
      account.drinks.create!(drink_type: 'Beer', ounces: '20', percentage: '40', created_at: Date.today - 28)
      expect(account.weeks_status_count('Perfect')).to eq (31) # Should add up to current_week count
      expect(account.weeks_status_count('Really Good')).to eq (1)
      expect(account.weeks_status_count('Good')).to eq (1)
      expect(account.weeks_status_count('Over')).to eq (1)
      expect(account.weeks_status_count('Really Over')).to eq (1)
    end

    it '#generate_weekly_breakdown' do # Revisit (not enough detail)
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 14)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4', created_at: Date.today - 10)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5', created_at: Date.today - 6)
      expect(account.generate_weekly_breakdown).to be_a (Array)
      expect(account.generate_weekly_breakdown.first).to be_a (Hash)
      expect(account.generate_weekly_breakdown.first).to have_key (:count)
      expect(account.generate_weekly_breakdown.first).to have_key (:start)
      expect(account.generate_weekly_breakdown.first).to have_key (:end)
      expect(account.generate_weekly_breakdown.first).to have_key (:units)
      expect(account.generate_weekly_breakdown.first).to have_key (:drinks)
    end
  end
end