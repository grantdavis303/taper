require 'rails_helper'

RSpec.describe Drink, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:account_id) }
    it { should validate_presence_of(:drink_type) }
    it { should validate_presence_of(:ounces) }
    it { should validate_presence_of(:percentage) }
    it { should validate_numericality_of(:account_id) }
    it { should validate_numericality_of(:ounces) }
    it { should validate_numericality_of(:percentage) }
  end

  describe 'relationships' do
    it { should belong_to(:account) }
  end

  describe 'instance methods' do
    it '#formatted_created_at' do
      role = Role.create!(
        name: 'user'
      )
      user = User.create!(
        first_name: 'test',
        last_name: 'user',
        email: 'test@test.com',
        phone_number: '0123456789',
      )
      account = Account.create!(
        user_id: user.id,
        role_id: role.id,
        username: 'testuser1',
        password: 'Password123!'
      )
      new_drink = account.drinks.create!(
        drink_type: 'Beer',
        ounces: '16',
        percentage: '8.1'
      )
      expect(new_drink.formatted_created_at).to eq (new_drink.created_at.strftime('%A, %B %-d, %Y @ %l:%M%P %Z'))
    end

    it '#units' do
      role = Role.create!(
        name: 'user'
      )
      user = User.create!(
        first_name: 'test',
        last_name: 'user',
        email: 'test@test.com',
        phone_number: '0123456789',
      )
      account = Account.create!(
        user_id: user.id,
        role_id: role.id,
        username: 'testuser1',
        password: 'Password123!'
      )
      new_drink1 = account.drinks.create!(
        drink_type: 'Beer',
        ounces: '16',
        percentage: '8.1'
      )
      new_drink2 = account.drinks.create!(
        drink_type: 'Wine',
        ounces: '5',
        percentage: '13.5'
      )
      expect(new_drink1.units).to eq (3.83)
      expect(new_drink2.units).to eq (2.00)
    end
  end
end