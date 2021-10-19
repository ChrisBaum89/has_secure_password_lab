class UsersController < ApplicationController
  def new
  end


  def create
    if user_params[:password] == user_params[:password_confirmation]
      @user = User.create(user_params)
      session[:user_id] = @user.id
      session[:name] = @user.name
      redirect_to root_path
    else
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

end
