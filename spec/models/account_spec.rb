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
    it '#formatted drinks' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      drink1 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      drink2 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      drink3 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.formatted_drinks).to eq ([drink3, drink2, drink1])
    end

    it '#drinks_today_units' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 1)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_today_units).to eq (3.19)
    end

    it '#drinks_today_count' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_today_count).to eq (3)
    end

    it '#drinks_week_units' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 7)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_week_units).to eq (3.19)
    end

    it '#drinks_week_count' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 7)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_week_count).to eq (2)
    end

    it '#drinks_year_units' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 365)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_year_units).to eq (3.19)
    end

    it '#drinks_year_count' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Date.today - 365)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_year_count).to eq (2)
    end

    it '#drinks_total_units' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_total_units).to eq (4.25)
    end

    it '#drinks_total_count' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drinks_total_count).to eq (3)
    end

    it '#days_without_drinking - has drinks' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5.2', created_at: Date.today - 2)
      expect(account.days_without_drinking).to eq (2)
    end

    it '#days_without_drinking - does not have drinks' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!', last_login: 'today')
      expect(account.days_without_drinking).to eq (0)
    end
  end
end