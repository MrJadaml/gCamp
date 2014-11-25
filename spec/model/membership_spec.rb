require 'rails_helper'

describe 'Member' do

  it 'should be able to add a membership to a project.' do
    bob = User.create!(
      email: 'bob@mail.com',
      first_name: 'bob',
      last_name: 'thing',
      password: 'password',
      password_confirmation: 'password'
    )

    project = Project.create!(name: 'pname')

    membership = bob.memberships.create!(
                   user_id: bob.id,
                   role: 'member',
                   project_id: project.id
                 )

    membership.role = 'owner'
    expect(membership.valid?).to be(true)
  end

end
