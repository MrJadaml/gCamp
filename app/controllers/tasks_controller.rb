class TasksController < ApplicationController

  def index
    if params[:all]
      @tasks = Task.order(params[:sort_by])
    else
      @tasks = Task.order(params[:sort_by]).where(complete: false)
    end
  end

  def show
    set_task
  end

  def new
    @task = Task.new
  end

  def edit
    set_task
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    set_task
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:complete, :description, :due_date)
    end
end
