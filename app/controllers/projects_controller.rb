class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.save
    redirect_to @project, notice: 'Created new project'
  end

  def show
    set_project
  end

  def edit
    set_project
  end

  def update
    set_project
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was updated'
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_path, notice: 'Project was destroyed!'
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
