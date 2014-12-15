class UsersController < ApplicationController
  skip_before_action :members_only
  before_action :update_authorization, only: [:update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'Successfully created user'
    else
      render :new
    end
  end

  def show
    set_user
    unless current_user.tracker_token.nil?
      @token_filter = TrackerAPI.new.token_filter(current_user.tracker_token)
    end
  end

  def edit
    set_user
    raise AccessDenied unless current_user.admin? || @user.id == current_user.id
  end

  def update
    set_user
    if current_user.admin?
      if @user.update(admin_update_params)
        redirect_to users_path, notice: "User was updated successfully"
      else
        render :edit
      end
    else
      if @user.update(user_params)
        redirect_to users_path, notice: "User was updated successfully"
      else
         render :edit
      end
    end
  end

  def destroy
    set_user
    @user.destroy
    redirect_to users_path, notice: "User was deleted successfully"
  end


  def share_projects?
    @user = User.find(params[:id])
    (current_user.memberships.pluck(:project_id) & @user.memberships.pluck(:project_id)).empty? != true
  end

  helper_method :record_is_current_users?, :share_projects?

  private

    def set_user
      @user = User.find(params[:id])
    end

    def update_authorization
      @user = User.find(params[:id])
      raise AccessDenied unless current_user.admin || @user.id == current_user.id
    end

    def admin_update_params
      params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :tracker_token,
      :admin
      )
    end

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :tracker_token
      )
    end
end
