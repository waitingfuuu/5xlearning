class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to '/'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def destroy
    Task.destroy(params[:id])
    redirect_to('/')
  end

  private
   def task_params
     params.require(:task).permit(:user_id, :title, :content, :tag, :build_time, :start_time, :end_time, :priority, :state)
   end
end