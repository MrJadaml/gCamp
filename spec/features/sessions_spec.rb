require 'rails_helper'

feature "Sessions" do

  scenario "Users can't sign in with blank password" do

    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: '   '
    within('.actions') do
      click_on 'Sign in'
    end
    expect(page).to have_content('Username / password combo is invalid')
  end

  scenario "Users can't sign in with blank email" do

    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: '   '
    fill_in 'Password', with: 'password'
    within('.actions') do
      click_on 'Sign in'
    end
    expect(page).to have_content('Username / password combo is invalid')
  end

  scenario "Users can sign in with valid information" do
    User.create!(
      email: 'mail@mail.com',
      password: 'password',
      first_name: 'Albert',
      last_name: 'Einstein'
    )

    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    within('.actions') do
      click_on 'Sign in'
    end
    expect(page).to have_content('Create Project')
  end


  scenario "Users can sign out" do
    User.create!(
      first_name: 'Albert',
      last_name: 'Einstein',
      email: 'mail@mail.com',
      password: 'password'
    )

    visit signin_path
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    within('.actions') do
      click_on 'Sign in'
    end
    expect(page).to have_content('Albert Einstein')
    click_on 'Sign Out'
    expect(page).to have_content('Sign Up')
  end
end
