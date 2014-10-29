class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    if params[:complete]
      @tasks = Task.where(complete: params[:complete])
    end
    if params[:sort_by]
      @tasks = Task.order(params[:sort_by])
    end
    if params[:complete] && params[:sort_by]
      @tasks = Task.where(complete: params[:complete]).order(params[:sort_by])
    end
  end

# Toggle the check boxes from task's index
  def complete
    @task = Task.find(params[:format])
      if @task.complete == true
        @task.update_attribute(complete: false)
      else
        @task.update_attribute(complete: true)
      end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
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
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
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
