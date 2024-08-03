require 'rails_helper'

RSpec.describe 'Sessions New', type: :feature do
  it 'has everything' do
    visit root_path

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
      expect(page).to have_link('Forgot Password')
    end
  end
end