require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'relationships' do
    it { should have_many(:accounts) }
    it { should have_many(:users).through(:accounts) }
  end

  describe 'validations' do
    subject { 
      role = Role.create!(name: 'user')
    }
    it { should validate_presence_of(:name) }
  end
end