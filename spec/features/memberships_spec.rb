require 'rails_helper'

feature 'Memberships' do

  scenario 'User adds a member to project' do

    project = create_project(name: 'Things')
    create_user

    visit project_path(project)

    click_on '0 Members'

    to have no "ed smi"
    to have no "member"
    select 'Ed Smith', from: 'membership_user_id'
    click on 'Add New Member'

    expec to have content "Ed success..
    to have "Ed smith"
    to have "member"
  end
end
