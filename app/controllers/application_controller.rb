class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :is_logged_in?
  helper_method :is_admin?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authorize
    if !current_user
      flash[:alert] = "You must be signed in and authorized to make this change."
      redirect_to root_path
    end
  end

  def is_logged_in?
    @current_user.present?
  end

  def is_admin?
    current_user && current_user.admin
  end
end
