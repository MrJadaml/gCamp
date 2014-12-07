class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])

  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create
    raise AccessDenied unless is_an_owner? || current_user.is_an_admin?
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
    raise AccessDenied unless is_an_owner? || current_user.is_an_admin?
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path, notice: "#{@membership.user.first_name.capitalize} was updated successfully"
    else
      render :index
    end
  end

  def destroy
    raise AccessDenied unless is_an_owner? || current_user.is_an_admin?
    @membership = @project.memberships.find(params[:id])
    @project.memberships.find(params[:id]).destroy
    redirect_to project_memberships_path, notice: "#{@membership.user.first_name.capitalize} was removed successfully"
  end

  def is_an_owner?
    @project.memberships.find_by(user_id: current_user.id).role == 'Owner'
  end

  helper_method :is_an_owner?

  private

    def membership_params
      params.require(:membership).permit(:role, :user_id, :project_id)
    end

end
