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
    visit support_index_path

    expect(page).to have_content ('Dashboard')
    expect(page).to have_content ('New Drink')
    expect(page).to have_content ('All Drinks')
    expect(page).to have_content ('Log Out')
  end

  it 'has everything' do
    account = Account.first

    visit support_index_path

    expect(page).to have_content ("FAQs")
  
    expect(page).to have_content ("What is this app?")
    expect(page).to have_content ("This app allows users to track what they drink by entering in values for a drink's ounces and alcohol-by-volume (ABV) percentage.")

    expect(page).to have_content ("Who is this app for?")
    expect(page).to have_content ("This app is for everyone! This app is for anyone that is curious what they drink on a daily, weekly, monthly, or yearly basis.")

    expect(page).to have_content ("What are alcoholic units?")
    expect(page).to have_content ("Alcoholic units are a simple way of expressing the quantity of pure alcohol in a drink. One unit equals 10ml or 8g of pure alcohol, which is around the amount of alcohol the average adult can process in an hour.")

    expect(page).to have_content ("What do the statuses Perfect, Under, Over, and Untracked mean?")
    expect(page).to have_content ("Perfect: Zero total alcoholic units (no drinks).")
    expect(page).to have_content ("Under: Less than 14 total alcoholic units (a few drinks).")
    expect(page).to have_content ("Over: More than 14 total alcoholic units (more than a few drinks).")
    expect(page).to have_content ("Untracked: No data.")

    expect(page).to have_content ("What's the significance of 14 alcoholic units?")
    expect(page).to have_content ('This number is considered to be the barrier between "low-risk" and "high-risk" drinking.')
    expect(page).to have_content ('Drinking less than 14 units a week is considered to be "low-risk" drinking, while drinking more than 14 units a week, regularly, is considered to be "high-risk."')
    expect(page).to have_content ('14 units is roughly equivalent to six pints of lager or one-and-a-half bottles of wine.')
  end
end