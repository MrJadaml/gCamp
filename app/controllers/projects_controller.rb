class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_parms)
    @project.save
    redirect_to @project, notice: 'Created new project'
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def project_parms
    params.require(:project).permit(:name)
  end

end
