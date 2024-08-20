require 'rails_helper'

RSpec.describe 'Sessions New', type: :feature do
  it 'has everything' do
    visit root_path

    within '.main_logo' do
      expect(page.find('img.logo')['src']).to eq ('/assets/test_logo-315f67f4cede5c5d08c10b18a1ef188ed12b5d26c4169bdb5521a2b5679fdff4.png')
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