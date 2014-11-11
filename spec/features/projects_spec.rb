require 'rails_helper'

feature "Projects" do

  scenario "Users can create a new project" do

    visit projects_path
    click_on 'Create Project'
    fill_in 'Name', with: 'New Project'
    click_on 'Create Project'
    expect(page).to have_content('New Project')
    expect(page).to have_content('Created new project')
  end

  scenario "Users can delete a project" do
    Project.create!(
      name: 'test project'
    )

    visit projects_path
    click_on 'test project'
    expect(page).to have_content('test project')
    click_on 'Destroy'
    expect(page).to have_no_content('test project')
  end

  scenario "Users can edit a project" do
    Project.create!(
      name: 'test project'
    )

    visit projects_path
    click_on 'test project'
    expect(page).to have_content('test project')
    click_on 'Edit'
    fill_in 'Name', with: 'edited project'
    click_on 'Update Project'
    expect(page).to have_content('edited project')
  end

  scenario "Users must enter a project name" do
    visit projects_path
    click_on 'Create Project'
    click_on 'Create Project'
    expect(page).to have_content("Name can't be blank")
  end

end
