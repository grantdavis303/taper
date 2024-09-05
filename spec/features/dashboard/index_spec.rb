require 'rails_helper'

RSpec.describe 'Dashboard Index', type: :feature do
  before(:each) do
    role = Role.create!(name: 'user')
    user = User.create!(first_name: 'test', last_name: 'test', email: 'test1@test.com', phone_number: '121-456-7891')
    account = Account.create!(user_id: user.id, role_id: role.id, username: 'testuser1', password: 'Password123!')

    visit root_path

    fill_in (:username), with: 'testuser1'
    fill_in (:password), with: 'Password123!'
    click_on('Login')
  end

  it 'has content for main navigation' do
    visit new_drink_path

    expect(page).to have_content ('Dashboard')
    expect(page).to have_content ('New Drink')
    expect(page).to have_content ('All Drinks')
    expect(page).to have_content ('Log Out')
  end

  xit 'has everything' do
    visit dashboard_index_path
  end
end