class RegistrationsController < PublicController
  skip_before_action :ensure_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation))
    if @user.save
      session[:id] =  @user.id
      redirect_to new_project_path, notice: "Successfully signed up"
    else
      render :new
    end
  end

end
