class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  PER = 6
  def index
    @search_params = task_search_params
    @tasks = Task.search(@search_params)
    if params[:title].present? && params[:status].present?
     @tasks = Task.where('title LIKE ? AND status LIKE ?', "%#{params[:title]}%", "%#{params[:status]}%" )
    elsif params[:title].present? && params[:status].blank?
      @tasks = Task.where('title LIKE ?', "%#{params[:title]}%")
    elsif params[:title].blank? && params[:status].present?
      @tasks = Task.where(status: params[:status])
    elsif params[:sort_creation]
      @tasks = Task.all.order(created_at: :desc)
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    else
      @tasks = Task.all.order(duedate: :desc)
    end
    @tasks = @tasks.page(params[:page]).per(PER)
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
      @task.duedate = Date.today
    else
      @task = Task.new
    end
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        flash[:success] = 'Task created'
        redirect_to tasks_path
      else
        flash.now[:danger] = 'Task cannot be created'
        render :new
      end
    end
  end

  def update
      if @task.update(task_params)
        flash[:success] = 'Task updated'
        redirect_to tasks_path
      else
        flash.now[:danger] = 'Task not updated'
        render :edit
      end
    end

  def destroy
    @task.destroy
    flash[:success] = 'Task deleted'
    redirect_to tasks_path
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :status )
  end

  def task_params
    params.require(:task).permit(:title, :content, :duedate, :priority, :status, :id)
  end
end
