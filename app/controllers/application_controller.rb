class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def new_user
    new_user = !current_user
  end
  helper_method :new_user

  def login_required
    unless current_user
      session[:redirect] = request.url
      redirect_to new_auth_path
    end
  end
  helper_method :login_required

end
