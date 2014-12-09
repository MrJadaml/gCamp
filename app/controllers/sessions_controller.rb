class SessionsController < PublicController
  skip_before_action :ensure_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect_back_or projects_path
    else
      @sign_in_error = "Username / password combo is invalid"
      render :new
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end


end
