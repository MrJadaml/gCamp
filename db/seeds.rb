User.delete_all
Project.delete_all
Task.delete_all
Comment.delete_all
Membership.delete_all

admin = User.create!(
first_name: 'Admin',
last_name: 'User',
email: 'admin@example.com',
password: 'password',
admin: true
)

owner = User.create!(
first_name: 'Owner',
last_name: 'User',
email: 'owner@example.com',
password: 'password'
)

member = User.create!(
first_name: 'Member',
last_name: 'User',
email: 'member@example.com',
password: 'password'
)

user = User.create!(
first_name: 'Basic',
last_name: 'User',
email: 'user@example.com',
password: 'password'
)

multiple_owners = Project.create!(name: 'Multiple Owners')
Membership.create!(
project: multiple_owners,
user: owner,
role: 'owner'
)
Membership.create!(
project: multiple_owners,
user: user,
role: 'owner'
)
Membership.create!(
project: multiple_owners,
user: member,
role: 'member'
)

task1 = Task.create!(
description: "Write 3 comments",
project: multiple_owners,
due_date: 4.days.from_now
)

task2 = Task.create!(
description: "Write 1 comment",
project: multiple_owners,
due_date: 5.days.from_now
)

3.times do
  Comment.create!(
  task: task1,
  user: owner,
  copy: Faker::Lorem.sentence
  )
end

Comment.create!(
task: task2,
user: member,
copy: Faker::Lorem.sentence
)

single_owner = Project.create!(name: 'Single Owner')
Membership.create!(
project: single_owner,
user: owner,
role: 'owner'
)
Membership.create!(
project: single_owner,
user: member,
role: 'member'
)






# User.delete_all
# Project.delete_all
#
# 20.times do
#   User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: 'password',
#     password_confirmation: 'password',
#   )
# end
#
# 12.times do
#   first_id = User.first.id
#   last_id = User.last.id
#   user = (first_id..last_id).to_a
#
#   project = Project.create!(name: Faker::App.name)
#   rand(8).times do
#     task = Task.create!(
#       description: Faker::Lorem.sentence,
#       complete: [true, false, false].sample,
#       due_date: Faker::Time.forward(7),
#       project_id: project.id,
#     )
#     rand(5).times do
#       Comment.create!(
#         copy: Faker::Lorem.sentence,
#         task_id: task.id,
#         user_id: user.sample,
#       )
#     end
#     rand(3).times do
#       Membership.create(
#         user_id: user.sample,
#         project_id: project.id,
#         role: ['Member', 'Member', 'Owner'].sample,
#       )
#     end
#   end
# end
