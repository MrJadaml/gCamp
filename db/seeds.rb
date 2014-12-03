User.delete_all
Project.delete_all

20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
  )
end

12.times do
  first_id = User.first.id
  last_id = User.last.id
  user = (first_id..last_id).to_a

  project = Project.create!(name: Faker::App.name)
  rand(8).times do
    task = Task.create!(
      description: Faker::Lorem.sentence,
      complete: [true, false, false].sample,
      due_date: Faker::Time.forward(7),
      project_id: project.id,
    )
    rand(5).times do
      Comment.create!(
        copy: Faker::Lorem.sentence,
        task_id: task.id,
        user_id: user.sample,
      )
    end
    rand(3).times do
      Membership.create(
        user_id: user.sample,
        project_id: project.id,
        role: ['Member', 'Member', 'Owner'].sample,
      )
    end
  end
end
