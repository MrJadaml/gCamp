class CommentsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(params.require(:comment).permit(:copy, :user_id, :task_id))
    @comment.user_id = current_user.id
    @comment.save
    redirect_to project_task_path(@project, @task)
  end

end
