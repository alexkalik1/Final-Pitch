class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :authorize

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_logged_in
    return true if current_user

    return redirect_to root_path
  end

  def authorize
    redirect_to 'users#new' unless current_user
  end
end
