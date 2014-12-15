class ProjectsController < ApplicationController
  skip_before_action :members_only, only: [:index, :new, :create, :tracker_projects]
  before_action :update_authorization, only: [:update]
  before_action :delete_authorization, only: [:destroy]

  def index
    @projects = Project.all
    @tracker_projects = TrackerAPI.new.projects(current_user.tracker_token)
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
    tracker_api = TrackerAPI.new
    @tracker_projects = tracker_api.projects(current_user.tracker_token)
  end

  def edit
    set_project
    raise AccessDenied unless current_user.is_project_owner?(@project) || current_user.admin?
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

  def tracker_projects
    track_api = TrackerAPI.new
    if params[:all]
      @tracker_stories = track_api.stories(current_user.tracker_token, params[:id])
    elsif params[:unstarted]
      @tracker_stories = track_api.unstarted(current_user.tracker_token, params[:id])
    else
      @tracker_stories = track_api.rejected(current_user.tracker_token, params[:id])
    end
    @tracker_project = track_api.project(current_user.tracker_token, params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def update_authorization
    set_project
    raise AccessDenied unless current_user.admin? || current_user.is_project_owner?(@project)
  end

  def delete_authorization
    set_project
    raise AccessDenied unless current_user.admin? || current_user.is_project_owner?(@project)
  end

end
