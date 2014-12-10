require 'rails_helper'

feature "Projects" do
  before do
    @user = create_user admin: true
    @project = create_project name: 'test project'
    @membership = create_membership user_id: @user, project_id: @project, role: 'Owner'
    sign_in @user
  end

  scenario "Users can create a new project" do
    visit projects_path
    click_on 'Create Project'
    fill_in 'Name', with: 'New Project'
    click_on 'Create Project'
    expect(page).to have_content('New Project')
    expect(page).to have_content('Created a new project')
  end

  scenario "Users can delete a project" do
    visit projects_path
    click_on 'test project'
    expect(page).to have_content('test project')
    click_on 'Destroy'
    expect(page).to have_no_content('test project')
  end

  scenario "Users must enter a project name" do
    visit projects_path
    click_on 'Create Project'
    click_on 'Create Project'
    expect(page).to have_content("Name can't be blank")
  end

end
