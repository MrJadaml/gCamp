class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all

    if params[:complete] == 'false'
      @tasks = Task.where(complete: false)
    elsif params[:complete] == ''
      @tasks = Task.where(complete: false)
    elsif params[:complete] == 'true'
      @tasks = Task.all
    end

    if params[:sort_by] == 'description'
      @tasks = Task.order(:description)
    elsif params[:sort_by] == 'complete'
      @tasks = Task.order(:complete)
    elsif params[:sort_by] == 'due_date'
      @tasks = Task.order(:due_date)
    end

  end

  def complete

    @task = Task.find(params[:format])
      puts "*" * 80
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
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
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
