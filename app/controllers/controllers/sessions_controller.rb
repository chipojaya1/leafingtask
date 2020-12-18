class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'login failed'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:info] = 'logged out'
    redirect_to new_session_path
  end
end
