class UsersController < ApplicationController

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
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user.update(user_params)
      redirect_to users_path, notice: "User was updated successfully"
    else
       render :edit
    end
  end

  def destroy
    set_user
    User.find(params[:id]).destroy
    redirect_to users_path, notice: "User was deleted successfully"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit( :first_name,
                                    :last_name,
                                    :email,
                                    :password,
                                    :password_confirmation
                                  )
    end
end
