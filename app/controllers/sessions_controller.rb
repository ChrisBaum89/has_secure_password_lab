class SessionsController < ApplicationController

  def new

  end

  def create
    if session[:id]
      redirect_to '/'
    elsif params[:user][:name] != nil && params[:user][:name] != ""
      if @user = User.find_by(name: params[:user][:name])
        return head(:forbidden) unless @user.authenticate(params[:user][:password])
      else
        @user = User.create
      end
      session[:user_id] = @user.id
      session[:name] = @user.name
      redirect_to '/'
    else
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  def current_user
    return head(:forbidden) unless session.include? :name
  end
end
