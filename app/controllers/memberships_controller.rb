class MembershipsController < ApplicationController
  before_action :set_project
  before_action :delete_authorization, only: [:destroy]
  before_action :update_authorization, only: [:update]


  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create
    raise AccessDenied unless role_is_owner? || current_user.admin?
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path,
      notice: "#{@membership.user.first_name.capitalize} was added successfully"
    else
      @memberships = @project.memberships.all
      render :index
    end

  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path, notice: "#{@membership.user.first_name.capitalize} was updated successfully"
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])

    if @project.memberships.find(params[:id]).destroy && current_user.admin? || role_is_owner?
      redirect_to project_memberships_path, notice: "#{@membership.user.first_name.capitalize} was removed successfully"
    elsif record_owner?
      redirect_to projects_path, notice: "Your membership was removed successfully"
    else
      redirect_to project_memberships_path, notice: "You can't delete the last Owner"
    end
  end

  def role_is_owner?
    if @project.memberships.find_by(user_id: current_user.id) == nil
      false
    else
      @project.memberships.find_by(user_id: current_user.id).role =='Owner'
    end
  end

  def record_owner?
    @membership.user_id == current_user.id
  end

  helper_method :role_is_owner?

  private

    def membership_params
      params.require(:membership).permit(:role, :user_id, :project_id)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def delete_authorization
      @membership = @project.memberships.find(params[:id])
      raise AccessDenied unless current_user.admin? || @project.memberships.find_by(user_id: current_user.id).role =='Owner'|| @membership.user_id == current_user.id
    end

    def update_authorization
      @membership = @project.memberships.find(params[:id])
      raise AccessDenied unless current_user.admin? || role_is_owner?
    end

end
