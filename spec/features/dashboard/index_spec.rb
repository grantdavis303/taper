require 'rails_helper'

RSpec.describe 'Dashboard Index', type: :feature do
  before(:each) do
    role = Role.create!(id: 1, name: 'user')

    user = User.create!(
      first_name: 'Bob the Test Bot',
      last_name: 'Testerman',
      email: 'bob_the_test_bot@bot_test.com',
      phone_number: '123-456-789',
    )

    account = Account.create!(
      user_id: user.id,
      role_id: role.id,
      username: 'bob_the_test_bot123',
      password: 'Password123!',
    )

    visit root_path

    within '.login_form_container' do
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: 'Password123!'
      click_on('Login')
    end
  end

  it 'has content for main navigation' do
    visit new_drink_path

    expect(page).to have_content ('Dashboard')
    expect(page).to have_content ('New Drink')
    expect(page).to have_content ('All Drinks')
    expect(page).to have_content ('Log Out')
  end

  xit 'has everything' do
    account = Account.first

    visit dashboard_index_path

    expect(page).to have_content ("Welcome, #{account.user.first_name}")

    expect(page).to have_content ('Summary')
    expect(page).to have_content ('You are currently under the recommended 14 units of alcohol per week. Keep it up!')

    expect(page).to have_content ('Weekly Breakdown')
  end

  it 'updates weekly status depending on drink quantity' do
    account = Account.first

    visit dashboard_index_path

    expect(page).to have_content ("This Week Perfect")

    account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')
    visit dashboard_index_path

    expect(page).to have_content ("This Week Really Good")

    account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')
    account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')
    visit dashboard_index_path

    expect(page).to have_content ("This Week Good")

    account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')
    account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')
    visit dashboard_index_path

    expect(page).to have_content ("This Week Over")

    account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')
    account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')
    visit dashboard_index_path

    expect(page).to have_content ("This Week Really Over")
  end
end