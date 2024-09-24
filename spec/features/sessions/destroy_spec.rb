require 'rails_helper'

RSpec.describe 'Sessions Destroy', type: :feature do
  it 'successfully logs out of the application' do
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

    click_on('Log Out')

    expect(current_path).to eq (root_path)
    expect(page).to have_content('Successfully logged out.')
  end
end