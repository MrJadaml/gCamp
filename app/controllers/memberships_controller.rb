class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])

  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path, notice: "#{@membership.user.first_name} was created!"
    else
      @memberships = @project.memberships.all
      render :index
    end

  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path, notice: "#{@membership.user.first_name} was updated!"
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @project.memberships.find(params[:id]).destroy
    redirect_to project_memberships_path, notice: "#{@membership.user.first_name} Member was removed"
  end

  private

    def membership_params
      params.require(:membership).permit(:role, :user_id, :project_id)
    end

end
