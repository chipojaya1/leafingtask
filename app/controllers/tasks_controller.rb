class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true)
    if params[:title].present? && params[:status].present?
      @tasks = Task.where('title LIKE ? AND status LIKE ?', "%#{params[:title]}%", "%#{params[:status]}%" )
    elsif params[:title].present? && params[:status].blank?
      @tasks = Task.where('title LIKE ?', "%#{params[:title]}%")
    elsif params[:title].blank? && params[:status].present?
      @tasks = Task.where(status: params[:status])
    elsif params[:sort_expired]
      @tasks = Task.order(duedate: :desc)
    else
      @tasks = Task.order(updated_at: :desc)
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

  def task_params
    params.require(:task).permit(:title, :content, :duedate, :priority, :status, :id)
  end
end
