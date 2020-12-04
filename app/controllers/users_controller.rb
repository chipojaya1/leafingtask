class UsersController < ApplicationController
  PER = 6

  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User was successfully created'
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = current_user
    @tasks = @user.tasks&.page(params[:page]).per(PER)
    redirect_to tasks_path if @user.id !=  params[:id].to_i
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
