class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
    @task = Task.new(task_params)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'Task created'
      redirect_to @task
    else
      flash.now[:danger] = 'Task cannot be created'
      render :new
      end
    end

  def edit
  end

  def update
      if @task.update(task_params)
        flash[:success] = 'Task updated'
      else
        flash.now[:danger] = 'Task not updated'
        render :edit
      end
    end

  def destroy
    @task.destroy
    flash[:success] = 'Task created'
    redirect_to tasks_url
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :duedate, :status, :priority)
  end
end
