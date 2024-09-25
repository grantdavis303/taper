require 'rails_helper'

RSpec.describe 'Drinks Edit', type: :feature do
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
    account = Account.first
    drink = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')

    visit edit_drink_path(drink)

    expect(page).to have_content ('Dashboard')
    expect(page).to have_content ('New Drink')
    expect(page).to have_content ('All Drinks')
    expect(page).to have_content ('Log Out')
  end

  it 'has content for updating an existing drink' do
    account = Account.first
    drink = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')

    visit edit_drink_path(drink)

    expect(page).to have_content('Update Drink')

    within '.edit_drink_input' do
      expect(page).to have_content ('Drink Type:')
      expect(page).to have_field (:drink_type)
      expect(page).to have_content ('Ounces:')
      expect(page).to have_field (:ounces)
      expect(page).to have_content ('ABV Percentage:')
      expect(page).to have_field (:percentage)
      expect(page).to have_button ('Update Drink')
    end
  end
end