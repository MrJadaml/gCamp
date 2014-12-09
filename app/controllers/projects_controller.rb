class ProjectsController < ApplicationController
  skip_before_action :members_only, only: [:index, :new, :create]
  before_action :update_authorization, only: [:update]
  before_action :delete_authorization, only: [:destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.memberships.create!(user_id: current_user.id, project_id: @project, role: 'Owner')
      redirect_to project_tasks_path(@project), notice: 'Created a new project'
    else
      render :new
    end
  end

  def show
    set_project
  end

  def edit
    set_project
    raise AccessDenied unless role_is_owner? || current_user.admin?
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


  def role_is_owner?
    @project.memberships.find_by(user_id: current_user.id).role =='Owner'
  end

  helper_method :role_is_owner?

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def update_authorization
    set_project
    raise AccessDenied unless current_user.admin? || role_is_owner?
  end

  def delete_authorization
    set_project
    raise AccessDenied unless current_user.admin? || role_is_owner?
  end

end
