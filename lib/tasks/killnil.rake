namespace :kill do
  desc 'kill nil data'
  task nil: :environment do
    # nil_user_comments = Comment.where.not(user_id: User.all)
    # nil_task_comments = Comment.where.not(task_id: Task.all)
    #
    # nil_user_memberships = Membership.where.not(user_id: User.all)
    # nil_project_memberships = Membership.where.not(project_id: Project.all)

    Comment.where.not(user_id: User.pluck(:id)).delete_all
    Comment.where.not(task_id: Task.pluck(:id)).delete_all

    Membership.where.not(user_id: User.pluck(:id)).delete_all
    Membership.where.not(project_id: Project.pluck(:id)).delete_all
  end

end
