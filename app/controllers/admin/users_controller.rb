class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :admin_necessary
  PER = 6

  def index
    @users = User.all.order(created_at: :asc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user.id)
    else
      flash.now[:danger] = "User registration failed"
      render :new
    end
  end

  def show
    @tasks = Task.where(user_id: @user.id)
  end

  def edit
  end

  def update
    puts @user
    if @user.update(user_params)
      flash[:success] = "update successful"
      redirect_to admin_user_path
    else
      flash.now[:danger] = "update failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:info] = "#{@user.name} deleted"
      redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def admin_necessary
    unless current_user.admin?
      flash[:notice] = "only for admins！"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
