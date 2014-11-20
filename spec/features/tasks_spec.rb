require 'rails_helper'
require 'date'

feature "Tasks" do

  scenario "Users can create a new task" do
    project = Project.create!(name: 'name')

    visit project_tasks_path(project)
    click_on 'Create Task'
    fill_in 'Description', with: 'wowza'
    fill_in 'Due', with: '11/11/2015'
    click_on 'Create Task'
    expect(page).to have_content('Task was successfully created.')
    expect(page).to have_content('wowza')
  end

  scenario "Users can edit a task" do
    project = Project.create!(name: 'name')

    Task.create!(
      description: 'wowza',
      due_date: '11/11/2015'

    )

    visit project_tasks_path(project)
    expect(page).to have_content('wowza')
    click_on 'Edit'
    expect(page).to have_content('Editing task')
    fill_in 'Description', with: 'wow pow'
    fill_in 'Due', with: '11/11/2015'
    check 'Complete'
    click_on 'Update Task'
    expect(page).to have_content('Task was successfully updated.')
    expect(page).to have_content('wow pow')
    # click_on 'Edit'
    # (:checkbox).should be_checked
  end

  scenario "Users can delete a task" do
    skip

    Task.create!(
      description: 'wowza',
      due_date: '11/11/2015'

    )

    visit tasks_path
    expect(page).to have_content('wowza')
    click_on 'Destroy'
    expect(page).to have_content('Task was successfully destroyed.')
    expect(page).to have_no_content('wowza')
  end

  scenario 'users must enter description' do
    skip

    visit tasks_path
    click_on 'Create Task'
    click_on 'Create Task'
    expect(page).to have_content("Description can't be blank")
  end

  scenario 'Users cannot enter a date in the past when creating a task' do
    skip

    today = Date.today.strftime("%d/%m/%Y")
    old_date = (Date.today-20).strftime("%d/%m/%Y")

    visit tasks_path
    click_on 'Create Task'
    fill_in 'Description', with: 'some task'
    fill_in "Due", with: '11/11/2013'
    click_on 'Create Task'
    #expect(page).to have_content ''
  end

end
