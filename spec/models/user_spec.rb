require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_one(:account) }
    it { should have_one(:role).through(:account) }
  end

  describe 'validations' do
    subject { 
      user = User.new(first_name: 'test', last_name: 'test', email: 'test_user@test.com', phone_number: '123-456-7890')
    }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'custom validations' do
    it 'validate valid_email' do
      user1 = User.new(first_name: 'Grant', last_name: 'Davis', email: '123email', phone_number: '123-456-7890')
      user2 = User.new(first_name: 'Grant', last_name: 'Davis', email: '123email@test', phone_number: '123-456-7890')
      user3 = User.new(first_name: 'Grant', last_name: 'Davis', email: '123email.test', phone_number: '123-456-7890')
      user4 = User.new(first_name: 'Grant', last_name: 'Davis', email: '123email@test.com', phone_number: '123-456-7890')
      expect(user1.valid?).to eq (false)
      expect(user2.valid?).to eq (false)
      expect(user3.valid?).to eq (false)
      expect(user4.valid?).to eq (true)
    end
  end
end