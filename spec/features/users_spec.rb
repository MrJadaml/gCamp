require 'rails_helper'

feature "Users" do
  before do
    @user = create_user
    sign_in @user
  end

  scenario 'users must enter first and last name and email' do
    visit users_path
    click_on 'Create User'
    click_on 'Create User'
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

  scenario 'users must enter unique email' do
    visit users_path
    click_on 'Create User'
    fill_in 'First name', with: 'Carl'
    fill_in 'Last name', with: 'Sagen'
    fill_in 'Email', with: 'smart@mail.com'
    click_on 'Create User'
    expect(page).to have_content("Email has already been taken")
  end

end
