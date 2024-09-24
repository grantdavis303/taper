require 'rails_helper'

RSpec.describe 'Drinks Index', type: :feature do
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
    visit drinks_path

    expect(page).to have_content ('Dashboard')
    expect(page).to have_content ('New Drink')
    expect(page).to have_content ('All Drinks')
    expect(page).to have_content ('Log Out')
  end

  it 'has content for no drinks' do
    visit drinks_path

    expect(page).to have_content ('All Drinks (0)')
    expect(page).to have_content ('There are currently no drinks.')
  end

  it 'has content for one drink' do
    account = Account.first
    drink = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')

    visit drinks_path

    expect(page).to have_content ("All Drinks (#{account.drinks.count})")

    within '.drink' do
      expect(page).to have_content ("Type: #{drink.drink_type}")
      expect(page).to have_content ("Ounces: #{drink.ounces}")
      expect(page).to have_content ("ABV%: #{drink.percentage}")
      expect(page).to have_content ("Units: #{drink.units}")
      expect(page).to have_content ("Created: #{drink.formatted_created_at}")
    end
  end

  xit 'has content for multiple drinks' do
  end

  xit 'successfully updates a drink' do
  end

  xit 'successfully deletes a drink' do
  end
end