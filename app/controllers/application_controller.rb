class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_logged_in, :members_only

  def current_user
    User.find_by(id: session[:id])
  end

  def ensure_logged_in
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

  helper_method :current_user

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :serve_404

  def members_only
    @project = Project.find(params[:project_id] || params[:id])
    unless @project.memberships.pluck(:user_id).include?(current_user.id) || current_user.admin
      raise AccessDenied
    end
  end

  def serve_404
    render 'public/404', status: :not_found, layout: false
  end
end
