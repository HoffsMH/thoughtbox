class SessionsController < ApplicationController
  def new
  end

  def create
   user = User.find_by(email: user_email)
    if user && user.authenticate(user_password)
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now.alert = "Invalid email or password"
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def user_password
    user_params[:password]
  end

  def user_email
    user_params[:email]
  end
end
