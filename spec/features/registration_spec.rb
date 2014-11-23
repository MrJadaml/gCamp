require 'rails_helper'

feature "Registration" do

  scenario "Users can't sign up with blank info" do

    visit root_path
    click_on 'Sign Up'
    fill_in 'Email', with: '   '
    fill_in 'Password', with: '   '
    click_on 'Sign up'
    expect(page).to have_content('Email can\'t be blank')
    expect(page).to have_content('Password can\'t be blank')
  end

  scenario "Users can't sign up with 2 different passwords" do
    visit root_path
    click_on 'Sign Up'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'wrongpass'
    click_on 'Sign up'
    expect(page).to have_content('Password confirmation doesn\'t match Password')
  end

  scenario "Users can sign up with valid information" do
    visit root_path
    click_on 'Sign Up'
    fill_in 'First name', with: 'Billy'
    fill_in 'Last name', with: 'Bob'
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    within('.actions') do
      click_on 'Sign up'
    end
    expect(page).to have_content('Billy Bob')
  end
end
