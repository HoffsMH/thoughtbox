class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    if !current_user
      redirect_to controller: "sessions", action: "new"
    end
  end

  def current_user
    User.find_by(id: session[:user_id]) if session[:user]
  end
end
