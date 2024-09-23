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

  xit 'successfully creates a new user_account' do
  end
end