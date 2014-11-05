require 'rails_helper'

feature "Users" do

  scenario "Users can create a new user" do

    visit users_path
    click_on 'Create User'
    fill_in 'First name', with: 'Albert'
    fill_in 'Last name', with: 'Einstein'
    fill_in 'Email', with: 'smart@mail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Create User'
    expect(page).to have_content('Successfully created user')
    expect(page).to have_content('Albert')
    expect(page).to have_content('Einstein')
    expect(page).to have_content('smart@mail.com')

  end

  scenario "User can edit a user" do
    User.create!(
      first_name: 'Albert',
      last_name: 'Einstein',
      email: 'smart@mail.com',
      password: 'password',
      password_confirmation: 'password'
    )

    visit users_path
    expect(page).to have_content('Albert')
    expect(page).to have_content('Einstein')
    expect(page).to have_content('smart@mail.com')
    click_on 'Edit'
    expect(page).to have_content('Edit user')
    fill_in 'First name', with: 'Carl'
    fill_in 'Last name', with: 'Sagen'
    fill_in 'Email', with: 'cosmos@mail.com'
    # fill_in 'Password', with: 'password'
    # fill_in 'Password confirmation', with: 'password'
    click_on 'Update User'
    expect(page).to have_content('User was updated successfully')
    expect(page).to have_content('Carl')
    expect(page).to have_content('Sagen')
    expect(page).to have_content('cosmos@mail.com')

  end

  scenario "User can delete a user" do
    User.create!(
      first_name: 'Albert',
      last_name: 'Einstein',
      email: 'smart@mail.com',
      password: 'password',
      password_confirmation: 'password'
    )

    visit users_path
    expect(page).to have_content('Albert')
    click_on 'Edit'
    click_on 'Delete User'
    expect(page).to have_content('User was deleted successfully')
    expect(page).to have_no_content('Albert')
  end

end
