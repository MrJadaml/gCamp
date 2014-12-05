class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_logged_in

  def current_user
    User.find_by(id: session[:id])
  end

  def ensure_logged_in
    unless current_user 
      redirect_to signin_path
    end
  end

  helper_method :current_user

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :serve_404

  def serve_404
    render 'public/404', status: :not_found, layout: false
  end
end
