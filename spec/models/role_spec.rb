require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'validations' do
    subject { 
      role = Role.create!(name: 'user')
    }
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many(:accounts) }
    it { should have_many(:users).through(:accounts) }
  end
end