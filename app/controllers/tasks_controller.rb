class TasksController < ApplicationController
  before_action :find_task, only: [:update, :edit]
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    Task.destroy(params[:id])
    redirect_to root_path
  end

  private
   def task_params
     params.require(:task).permit(:user_id, :title, :content, :tag, :build_time, :start_time, :end_time, :priority, :state)
   end

   def find_task
    @task = Task.find(params[:id])
  end
end

