class TasksController < ApplicationController

  def index


    @tasks = Task.order(params[:complete]).where(complete: false)

  # if params[:complete]
  #   @tasks = Task.order(params[:sort_by])
  #
  #
  # elsif params[:complete] && params[:sort_by]
  #     @tasks = Task.where(complete: params[:complete]).order(params[:sort_by])
  #   end
    #

    # if params[:show_completed]
    #   @tasks = Task.order("#{sort_column} #{sort_direction}")
    # else
    #   @tasks = Task.order("#{sort_column} #{sort_direction}").where(complete: false)
    # end
  #
  #
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

    # Toggles check boxes from task's index
    def complete
      @task = Task.find(params[:format])
        if @task.complete == true
          @task.update_attribute(complete: false)
        else
          @task.update_attribute(complete: true)
        end
    end
end
