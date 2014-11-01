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
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    set_task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    set_task
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:complete, :description, :due_date)
    end
end
