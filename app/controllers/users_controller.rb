class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :create, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to @user
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was updated."
      redirect_to '/users'
    else
       render edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
