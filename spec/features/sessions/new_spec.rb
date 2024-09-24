require 'rails_helper'

RSpec.describe 'Sessions New', type: :feature do
  it 'has everything' do
    visit root_path

    within '.main_logo' do
      expect(page.find('img.logo')['src']).to eq ('/assets/test_logo_2-96c72adbae30077262b6e8acccc4e87d7272740ab4aea875cbff90f36dc2c424.jpeg')
    end

    within '.login_form_container' do
      expect(page).to have_content('Login')
      expect(page).to have_content('Username')
      expect(page).to have_field(:username)
      expect(page).to have_content('Password')
      expect(page).to have_field(:password)
      expect(page).to have_unchecked_field(:remember_me)
      expect(page).to have_content('Remember Me')
      expect(page).to have_button('Login')
    end

    within '.links' do
      expect(page).to have_link('Create Account')
      # expect(page).to have_link('Forgot Username')
      # expect(page).to have_link('Forgot Password')
    end
  end

  it 'successfully logs in a user to the application' do
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

    expect(current_path).to eq (dashboard_index_path)
    expect(page).to have_content('Successfully logged in.')
  end

  it 'does not log in a user to the application if the user_account does not exist' do
    visit root_path

    within '.login_form_container' do
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: 'Password123!'
      click_on('Login')
    end

    expect(current_path).to eq (root_path)
    expect(page).to have_content('User not found.')
  end

  it 'does not log in a user to the application if the username is not correct' do
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
      fill_in (:username), with: 'bob_the_test_bot1234'
      fill_in (:password), with: 'Password123!'
      click_on('Login')
    end

    expect(current_path).to eq (root_path)
    expect(page).to have_content('User not found.')
  end

  it 'does not log in a user to the application if the password is not correct' do
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
      fill_in (:password), with: 'Password1234!'
      click_on('Login')
    end

    expect(current_path).to eq (root_path)
    expect(page).to have_content('Bad credentials. Please try again.')
  end
end