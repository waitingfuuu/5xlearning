class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
    format.html { render :new, status: :unprocessable_entity }
  end

  def update
  format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
  format.html { render :edit, status: :unprocessable_entity }
  end

  def destroy
    @task.destroy
    format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:task_id, :task_user, :task_title, :task_content, :task_tag, :task_build_time, :task_start_time, :task_end_time, :task_priority, :task_state)
    end
end
