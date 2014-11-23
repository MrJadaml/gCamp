require 'rails_helper'
feature 'Comment' do

before(:each) do
  @user = User.create!(
    first_name: 'Albert',
    last_name: 'Einstein',
    email: 'ae@mail.com',
    password: 'password',
    password_confirmation: 'password'
  )

  @project = Project.create!(name: 'project name')

  @task = Task.create!(
    description: 'task description',
    complete: true,
    due_date: '01/01/2099',
    project_id: @project.id
  )

end

  scenario 'can add a comment to the tasks show page' do
    # comment = Comment.create!(
    #   copy: 'things and stuff'
    # )
    visit project_task_path(@project, @task)
    # expect(page).to have_content('things and stuff')
    fill_in 'Comment', with: 'things and stuff'
    click_on 'Create Comment'
  end

end
