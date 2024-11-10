require 'rails_helper'

RSpec.describe 'Drinks New', type: :feature do
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

  it 'has content for adding a new drink' do
    visit new_drink_path

    expect(page).to have_content ('Add a Drink')

    within '.new_drink_input' do
      expect(page).to have_content ('Drink Type:')
      expect(page).to have_select (:drink_type), options: ['Beer', 'Wine', 'Spirit', 'Seltzer', 'Cider', 'Other']
      expect(page).to have_content ('Ounces:')
      expect(page).to have_field (:ounces)
      expect(page).to have_content ('ABV Percentage:')
      expect(page).to have_field (:percentage)
      expect(page).to have_button ('Add Drink')
    end
  end

  it 'successfully creates a new drink' do
    visit new_drink_path

    user = User.first

    expect(user.account.drinks.count).to eq (0)

    within '.new_drink_input' do
      fill_in (:ounces), with: '12'
      fill_in (:percentage), with: '5.4'
      click_on('Add Drink')
    end

    expect(current_path).to eq (dashboard_index_path)
    expect(user.account.drinks.count).to eq (1)
  end

  it 'does not create a new drink if ounces is blank' do
    visit new_drink_path

    user = User.first

    expect(user.account.drinks.count).to eq (0)

    within '.new_drink_input' do
      fill_in (:ounces), with: ''
      fill_in (:percentage), with: '5.4'
      click_on('Add Drink')
    end

    expect(current_path).to eq (new_drink_path)
    expect(page).to have_content ("Ounces can't be blank and Ounces is not a number.")
    expect(user.account.drinks.count).to eq (0)
  end

  it 'does not create a new drink if percentage is blank' do
    visit new_drink_path

    user = User.first

    expect(user.account.drinks.count).to eq (0)

    within '.new_drink_input' do
      fill_in (:ounces), with: '12'
      fill_in (:percentage), with: ''
      click_on('Add Drink')
    end

    expect(current_path).to eq (new_drink_path)
    expect(page).to have_content ("Percentage can't be blank and Percentage is not a number.")
    expect(user.account.drinks.count).to eq (0)
  end
end