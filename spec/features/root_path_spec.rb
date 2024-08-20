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
      expect(page).to have_link('Forgot Username')
      expect(page).to have_link('Forgot Password')
    end
  end
end