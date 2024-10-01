require 'rails_helper'

RSpec.describe 'Drinks Index', type: :feature do
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
    visit drinks_path

    expect(page).to have_content ('Dashboard')
    expect(page).to have_content ('New Drink')
    expect(page).to have_content ('All Drinks')
    expect(page).to have_content ('Log Out')
  end

  it 'has content for no drinks' do
    visit drinks_path

    expect(page).to have_content ('All Drinks (0)')
    expect(page).to have_content ('There are currently no drinks.')
  end

  it 'has content for one drink' do
    account = Account.first
    drink = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')

    visit drinks_path

    expect(page).to have_content ("All Drinks (#{account.drinks.count})")

    within ".drink_#{drink.id}" do
      expect(page).to have_content ("Type: #{drink.drink_type}")
      expect(page).to have_content ("Ounces: #{drink.ounces}")
      expect(page).to have_content ("ABV%: #{drink.percentage}")
      expect(page).to have_content ("Units: #{drink.units}")
      # expect(page).to have_content ("Created: #{drink.formatted_created_at}")
    end
  end

  it 'has content for multiple drinks' do
    account = Account.first
    drink_1 = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')
    drink_2 = account.drinks.create!(drink_type: 'Beer', ounces: '16', percentage: '7')

    visit drinks_path

    expect(page).to have_content ("All Drinks (#{account.drinks.count})")

    within ".drink_#{drink_1.id}" do
      expect(page).to have_content ("Type: #{drink_1.drink_type}")
      expect(page).to have_content ("Ounces: #{drink_1.ounces}")
      expect(page).to have_content ("ABV%: #{drink_1.percentage}")
      expect(page).to have_content ("Units: #{drink_1.units}")
      # expect(page).to have_content ("Created: #{drink_1.formatted_created_at}")
    end

    within ".drink_#{drink_2.id}" do
      expect(page).to have_content ("Type: #{drink_2.drink_type}")
      expect(page).to have_content ("Ounces: #{drink_2.ounces}")
      expect(page).to have_content ("ABV%: #{drink_2.percentage}")
      expect(page).to have_content ("Units: #{drink_2.units}")
      # expect(page).to have_content ("Created: #{drink_2.formatted_created_at}")
    end
  end

  it 'successfully updates a drink' do
    account = Account.first
    drink = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')

    visit drinks_path

    within ".drink_#{drink.id}" do
      click_on('Update Drink')
    end

    within '.edit_drink_input' do
      select 'Spirit', :from => "drink_type"
      fill_in (:ounces), with: '2'
      fill_in (:percentage), with: '40'
      click_button ('Update Drink')
    end

    expect(current_path).to eq (drinks_path)
    expect(page).to have_content ('Drink updated successfully')

    within ".drink_#{drink.id}" do
      expect(page).to have_content ("Type: Spirit")
      expect(page).to have_content ("Ounces: 2")
      expect(page).to have_content ("ABV%: 40")
      expect(page).to have_content ("Units: 2.37")
      # expect(page).to have_content ("Created: Monday, September 30, 2024 @ 5:04 PM MDT")
    end
  end

  it 'successfully deletes a drink' do
    account = Account.first
    drink = account.drinks.create!(drink_type: 'Beer', ounces: '12', percentage: '3')

    visit drinks_path

    expect(page).to have_content ("All Drinks (#{account.drinks.count})")

    within ".drink_#{drink.id}" do
      expect(page).to have_content ("Type: #{drink.drink_type}")
      expect(page).to have_content ("Ounces: #{drink.ounces}")
      expect(page).to have_content ("ABV%: #{drink.percentage}")
      expect(page).to have_content ("Units: #{drink.units}")
      # expect(page).to have_content ("Created: #{drink.formatted_created_at}")
    end

    within ".drink_#{drink.id}" do
      click_on('Delete Drink')
    end

    expect(current_path).to eq (drinks_path)
    expect(page).to have_content ('Drink deleted successfully')
    expect(page).to have_content ('There are currently no drinks.')
  end
end