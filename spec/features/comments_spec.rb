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
end
