class TasksController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  def index
    if params[:all]
      @tasks = @project.tasks.order(params[:sort_by])
    else
      @tasks = @project.tasks.order(params[:sort_by]).where(complete: false)
    end
  end

  def show
    set_task
    @comment = @task.comments.new
    @comments = @task.comments.all
  end

  def new
    @task = @project.tasks.new
  end

  def edit
    set_task
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    set_task
    if @task.update(task_params)
      redirect_to project_tasks_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy
    redirect_to project_tasks_path(@project, @task), notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = @project.tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:complete, :description, :due_date)
    end
end
