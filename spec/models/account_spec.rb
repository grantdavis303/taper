require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'validations' do
    subject { 
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test_account@test.com', phone_number: '123-456-7890')
      role = Role.create!(name: 'user')
      Account.new(user_id: user.id, role_id: role.id, username: 'testuser', password: 'Testpassword1!')
    }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:role_id) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_numericality_of(:role_id) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should validate_length_of(:password).is_at_most(64) }
    it { should have_secure_password }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:role) }
    it { should have_many(:drinks) }
  end

  describe 'custom validations' do
    it 'validate valid_password' do
      role = Role.create!(name: 'user')
      user1 = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      user2 = User.create!(first_name: 'test', last_name: 'test', email: 'test2@test.com', phone_number: '122-456-7892')
      user3 = User.create!(first_name: 'test', last_name: 'test', email: 'test3@test.com', phone_number: '123-456-7893')
      user4 = User.create!(first_name: 'test', last_name: 'test', email: 'test4@test.com', phone_number: '124-456-7894')
      user5 = User.create!(first_name: 'test', last_name: 'test', email: 'test5@test.com', phone_number: '125-456-7895')
      account1 = Account.new(user_id: user1.id, role_id: role.id, username: 'testuser1', password: '')
      account2 = Account.new(user_id: user2.id, role_id: role.id, username: 'testuser2', password: 'testtest')
      account3 = Account.new(user_id: user3.id, role_id: role.id, username: 'testuser3', password: 'testtest1')
      account4 = Account.new(user_id: user4.id, role_id: role.id, username: 'testuser4', password: 'testtest1!')
      account5 = Account.new(user_id: user5.id, role_id: role.id, username: 'testuser5', password: 'Testtest1!')
      expect(account1.valid?).to eq (false)
      expect(account2.valid?).to eq (false)
      expect(account3.valid?).to eq (false)
      expect(account4.valid?).to eq (false)
      expect(account5.valid?).to eq (true)
    end
  end

  describe 'instance methods' do
    # Basic Queries

    it '#all_drinks_in_reverse_order' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      drink1 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      drink2 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      drink3 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.all_drinks_in_reverse_order).to eq ([drink3, drink2, drink1])
    end

    it '#weeks_this_year' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.weeks_this_year).to eq (Time.current.to_datetime.cweek)
    end

    # Drink Units and Counts

    it '#drink_units_today' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_today).to eq (4.25)
    end

    it '#drink_count_today' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_today).to eq (3)
    end

    it '#drink_units_this_week' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 7)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_this_week).to eq (3.19)
    end

    it '#drink_count_this_week' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 7)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_this_week).to eq (2)
    end

    it '#drink_units_this_month' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 33)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_this_month).to eq (3.19)
    end

    it '#drink_count_this_month' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 33)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_this_month).to eq (2)
    end

    it '#drink_units_this_year' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 365)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_this_year).to eq (3.19)
    end

    it '#drink_count_this_year' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 365)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_this_year).to eq (2)
    end

    it '#drink_units_all_time' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_units_all_time).to eq (4.25)
    end

    it '#drink_count_all_time' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.drink_count_all_time).to eq (3)
    end

    it '#drink_units_specific(start_date, end_date)' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 14)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4', created_at: Time.current.to_date - 10)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5', created_at: Time.current.to_date - 6)
      start_date = Time.current.to_date - 11
      end_date = Time.current.to_date - 2
      expect(account.drink_units_specific(start_date, end_date)).to eq (3.19)
    end

    it '#drink_count_specific(start_date, end_date)' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3', created_at: Time.current.to_date - 14)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '4', created_at: Time.current.to_date - 10)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5', created_at: Time.current.to_date - 6)
      start_date = Time.current.to_date - 11
      end_date = Time.current.to_date - 2
      expect(account.drink_count_specific(start_date, end_date)).to eq (2)
    end

    # Weekly Breakdowns

    it '#generate_single_week_breakdown' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      week = {
        start: Time.current.beginning_of_week,
        end: Time.current.end_of_week,
        units: 3.54,
        drinks: 2
      }
      expect(account.generate_single_week_breakdown).to be_a (Hash)
      expect(account.generate_single_week_breakdown).to have_key (:start)
      expect(account.generate_single_week_breakdown).to have_key (:end)
      expect(account.generate_single_week_breakdown).to have_key (:units)
      expect(account.generate_single_week_breakdown).to have_key (:drinks)
      expect(account.generate_single_week_breakdown).to have_key (:background_color)
      expect(account.generate_single_week_breakdown).to have_key (:font_color)
      expect(account.generate_single_week_breakdown).to have_key (:week_status)
      expect(account.generate_single_week_breakdown[:start]).to eq (Time.current.beginning_of_week.to_date)
      expect(account.generate_single_week_breakdown[:end]).to eq (Time.current.end_of_week.to_date)
      expect(account.generate_single_week_breakdown[:units]).to eq (3.54)
      expect(account.generate_single_week_breakdown[:drinks]).to eq (2)
      expect(account.generate_single_week_breakdown[:background_color]).to eq ('00CC00')
      expect(account.generate_single_week_breakdown[:font_color]).to eq ('FFFFFF')
      expect(account.generate_single_week_breakdown[:week_status]).to eq ('Really Good')
    end

    it '#generate_weekly_breakdown' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.generate_weekly_breakdown).to be_a (Array)
      expect(account.generate_weekly_breakdown.length).to eq (Time.current.to_date.cweek)
      expect(account.generate_weekly_breakdown.first).to be_a (Hash)
      expect(account.generate_weekly_breakdown.first).to have_key (:start)
      expect(account.generate_weekly_breakdown.first).to have_key (:end)
      expect(account.generate_weekly_breakdown.first).to have_key (:units)
      expect(account.generate_weekly_breakdown.first).to have_key (:drinks)
      expect(account.generate_weekly_breakdown.first).to have_key (:background_color)
      expect(account.generate_weekly_breakdown.first).to have_key (:font_color)
      expect(account.generate_weekly_breakdown.first).to have_key (:week_status)
      # expect(account.generate_weekly_breakdown.first[:start]).to eq (Time.current.beginning_of_year.to_date).beginning_of_day
      # expect(account.generate_weekly_breakdown.first[:end]).to eq (Time.current.beginning_of_year.to_date + current_day + 6).end_of_day
      expect(account.generate_weekly_breakdown.first[:units]).to eq (3.54)
      expect(account.generate_weekly_breakdown.first[:drinks]).to eq (2)
      expect(account.generate_weekly_breakdown.first[:background_color]).to eq ('00CC00')
      expect(account.generate_weekly_breakdown.first[:font_color]).to eq ('FFFFFF')
      expect(account.generate_weekly_breakdown.first[:week_status]).to eq ('Really Good')
    end

    it 'determine_week_design(week)' do
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      week = {
        start_date: Time.current.beginning_of_week,
        end_date: Time.current.end_of_week,
        units: 0,
        drinks: 0
      }
      expect(account.determine_week_design(week)).to eq ('Perfect')
      week[:units] = 1
      expect(account.determine_week_design(week)).to eq ('Really Good')
      week[:units] = 8
      expect(account.determine_week_design(week)).to eq ('Good')
      week[:units] = 15
      expect(account.determine_week_design(week)).to eq ('Over')
      week[:units] = 22
      expect(account.determine_week_design(week)).to eq ('Really Over')
    end

    # Weekly Status Counts

    it '#weeks_status_count(status_type)' do # Might cause some errors at beginning of new year
      role = Role.create!(name: 'user')
      user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
      account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')
      expect(account.weeks_status_count('Perfect')).to eq (1)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.weeks_status_count('Really Good')).to eq (1)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.weeks_status_count('Good')).to eq (1)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.weeks_status_count('Over')).to eq (1)
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '5')
      expect(account.weeks_status_count('Really Over')).to eq (1)
    end
  end
end