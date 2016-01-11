class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(new_user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to action: 'new'
    end
  end

  private
  def new_user_params
    params.require(:user).permit(:email, :password,
    :password_confirmation)
  end
end
