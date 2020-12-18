class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :logged_in?
  before_action :set_labels, only: [:new, :create, :edit, :update]
  PER = 6

  def index
    @search_params = task_search_params
    if params[:title].present? && params[:status].present? && params[:labels].present?
     @tasks = Task.where('title LIKE ? AND status LIKE ?', "%#{params[:title]}%", "%#{params[:status]}%").joins(:labels).where(labels: params[:labels])
    elsif params[:title].present? && params[:status].present?
      @tasks = Task.where('title LIKE ? AND status LIKE ?', "%#{params[:title]}%", "%#{params[:status]}%")
    elsif params[:title].present? && params[:labels].present?
      @tasks = Task.where('title LIKE ?', "%#{params[:title]}%").joins(:labels).where(labels: params[:labels])
    elsif params[:status].present? && params[:labels].present?
      @tasks = Task.where(status: params[:status]).joins(:labels).where(labels: params[:labels])
    elsif params[:title].present?
      @tasks = Task.where('title LIKE ?', "%#{params[:title]}%")
    elsif params[:status].present?
      @tasks = Task.where(status: params[:status])
    elsif params[:labels].present?
      @tasks = Task.joins(:labels).where(labels: params[:labels])
    elsif params[:sort_creation]
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order(priority: :desc).page(params[:page]).per(PER)
    else
      @tasks = Task.where(user_id: @current_user.id).order(duedate: :desc).page(params[:page]).per(PER)
    end
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
    @task = current_user.tasks.build(task_params)
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
    @task = current_user.tasks.find(params[:id])
  end

  def set_labels
    @labels = Label.all
  end

  def task_search_params
    params.fetch(:search, {}).permit(:title, :status, :label_id )
  end

  def task_params
    params.require(:task).permit(:title, :content, :duedate, :priority, :status, :id, { label_ids: [] })
  end
end
