require 'rails_helper'

RSpec.describe 'UserAccount New', type: :feature do
  it 'has everything' do
    visit new_user_account_path

    within '.main_logo' do
      expect(page.find('img.logo')['src']).to eq ('/assets/test_logo_2-96c72adbae30077262b6e8acccc4e87d7272740ab4aea875cbff90f36dc2c424.jpeg')
    end

    within '.new_user_container' do
      expect(page).to have_content('Create Account')
      expect(page).to have_content('* First Name:')
      expect(page).to have_field(:first_name)
      expect(page).to have_content('* Last Name:')
      expect(page).to have_field(:last_name)
      expect(page).to have_content('* Email:')
      expect(page).to have_field(:email)
      expect(page).to have_content('* Phone Number:')
      expect(page).to have_field(:phone_number)
      expect(page).to have_content('* Username')
      expect(page).to have_field(:username)
      expect(page).to have_content('* Password:')
      expect(page).to have_field(:password)
      expect(page).to have_content('* Password Confirmation:')
      expect(page).to have_field(:password_confirmation)
      expect(page).to have_button('Create Account')
      expect(page).to have_content('* Indicates a required field')
      expect(page).to have_content('Note: Password must be at least 8 characters long, contain one uppercase letter, one lowercase letter, and one special character.')
    end
  end

  it 'successfully creates a new user_account if all fields are valid' do
    Role.create!(id: 1, name: 'user')

    expect(User.all.count).to eq (0)
    expect(Account.all.count).to eq (0)

    visit new_user_account_path

    within '.new_user_container' do
      fill_in (:first_name), with: 'Bob the Test Bot'
      fill_in (:last_name), with: 'Testerman'
      fill_in (:email), with: 'bob_the_test_bot@bot_test.com'
      fill_in (:phone_number), with: '123-456-789'
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: 'Password123!'
      fill_in (:password_confirmation), with: 'Password123!'
      click_on('Create Account')
    end

    expect(current_path).to eq (root_path)
    expect(page).to have_content('Account created successfully.')
    expect(User.all.count).to eq (1)
    expect(Account.all.count).to eq (1)
  end

  it 'does not create a new user_account if the email is already taken' do
    Role.create!(id: 1, name: 'user')
    
    user = User.create!(
      first_name: 'Bob the Test Bot',
      last_name: 'Testerman',
      email: 'bob_the_test_bot@bot_test.com',
      phone_number: '123-456-789',
    )
    
    account = Account.create!(
      user_id: user.id,
      role_id: 1,
      username: 'bob_the_test_bot123',
      password: 'Password123!',
      created_at: 'Thur, 8 Aug 2024 12:00:00.000000000 UTC +00:00'
    )

    expect(User.all.count).to eq (1)
    expect(Account.all.count).to eq (1)

    visit new_user_account_path

    within '.new_user_container' do
      fill_in (:first_name), with: 'Bob the Test Bot'
      fill_in (:last_name), with: 'Testerman'
      fill_in (:email), with: 'bob_the_test_bot@bot_test.com'
      fill_in (:phone_number), with: '123-456-789'
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: 'Password123!'
      fill_in (:password_confirmation), with: 'Password123!'
      click_on('Create Account')
    end

    expect(current_path).to eq (new_user_account_path)
    expect(page).to have_content('Email has already been taken.')
    expect(User.all.count).to eq (1)
    expect(Account.all.count).to eq (1)
  end

  it 'does not create a new user_account if the username is already taken' do
    Role.create!(id: 1, name: 'user')
    
    user = User.create!(
      first_name: 'Bob the Test Bot',
      last_name: 'Testerman',
      email: 'bob_the_test_bot@bot_test.com',
      phone_number: '123-456-789',
    )
    
    account = Account.create!(
      user_id: user.id,
      role_id: 1,
      username: 'bob_the_test_bot123',
      password: 'Password123!',
      created_at: 'Thur, 8 Aug 2024 12:00:00.000000000 UTC +00:00'
    )

    expect(User.all.count).to eq (1)
    expect(Account.all.count).to eq (1)

    visit new_user_account_path

    within '.new_user_container' do
      fill_in (:first_name), with: 'Bob the Test Bot'
      fill_in (:last_name), with: 'Testerman'
      fill_in (:email), with: 'bob_the_test_bot2@bot_test.com'
      fill_in (:phone_number), with: '123-456-789'
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: 'Password123!'
      fill_in (:password_confirmation), with: 'Password123!'
      click_on('Create Account')
    end

    expect(current_path).to eq (new_user_account_path)
    expect(page).to have_content('Username has already been taken.')
    expect(User.all.count).to eq (1)
    expect(Account.all.count).to eq (1)
  end

  it 'does not create a new user_account if the email is empty' do
    Role.create!(id: 1, name: 'user')

    expect(User.all.count).to eq (0)
    expect(Account.all.count).to eq (0)

    visit new_user_account_path

    within '.new_user_container' do
      fill_in (:first_name), with: 'Bob the Test Bot'
      fill_in (:last_name), with: 'Testerman'
      fill_in (:email), with: ''
      fill_in (:phone_number), with: '123-456-789'
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: 'Password123!'
      fill_in (:password_confirmation), with: 'Password123!'
      click_on('Create Account')
    end

    expect(current_path).to eq (new_user_account_path)
    expect(page).to have_content("Email can't be blank and Email is not valid.")
    expect(User.all.count).to eq (0)
    expect(Account.all.count).to eq (0)
  end

  it 'does not create a new user_account if the password is empty' do
    Role.create!(id: 1, name: 'user')

    expect(User.all.count).to eq (0)
    expect(Account.all.count).to eq (0)

    visit new_user_account_path

    within '.new_user_container' do
      fill_in (:first_name), with: 'Bob the Test Bot'
      fill_in (:last_name), with: 'Testerman'
      fill_in (:email), with: 'bob_the_test_bot@bot_test.com'
      fill_in (:phone_number), with: '123-456-789'
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: ''
      fill_in (:password_confirmation), with: ''
      click_on('Create Account')
    end

    expect(current_path).to eq (new_user_account_path)
    expect(page).to have_content("Password can't be blank, Password is too short (minimum is 8 characters), and Password is missing all required characters.")
    expect(User.all.count).to eq (0)
    expect(Account.all.count).to eq (0)
  end

  it 'does not create a new user_account if the passwords do not match' do
    Role.create!(id: 1, name: 'user')

    expect(User.all.count).to eq (0)
    expect(Account.all.count).to eq (0)

    visit new_user_account_path

    within '.new_user_container' do
      fill_in (:first_name), with: 'Bob the Test Bot'
      fill_in (:last_name), with: 'Testerman'
      fill_in (:email), with: 'bob_the_test_bot@bot_test.com'
      fill_in (:phone_number), with: '123-456-789'
      fill_in (:username), with: 'bob_the_test_bot123'
      fill_in (:password), with: 'Password123!'
      fill_in (:password_confirmation), with: 'Password124!'
      click_on('Create Account')
    end

    expect(current_path).to eq (new_user_account_path)
    expect(page).to have_content('These passwords do not match.')
    expect(User.all.count).to eq (1)
    expect(Account.all.count).to eq (0)
  end
end