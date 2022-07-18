# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[update edit]

  def index
    @tasks = Task.order('created_at DESC') if params[:order_params].blank?
    @tasks = Task.order('end_time DESC') if params[:end_time] == 'desc'
    @tasks = Task.order('end_time ASC') if params[:end_time] == 'asc'

    if params[:search]
      @tasks = Task.where('title LIKE ?', "%#{params[:search]}%")

      @tasks = Task.where('state LIKE ?', '0') if params[:search] == t('task.pending')
      @tasks = Task.where('state LIKE ?', '1') if params[:search] == t('task.processing')
      @tasks = Task.where('state LIKE ?', '2') if params[:search] == t('task.solved')
    else
      @tasks = Task.all
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:notice] = t('flash.task_successfully_created')

      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:notice] = t('flash.task_successfully_edited')

      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Task.destroy(params[:id])

    flash[:notice] = t('flash.task_successfully_deleted')
    redirect_to root_path
  end

  def show; end

  private

  def task_params
    params.require(:task).permit(:user_id, :title, :content, :tag,
                                 :build_time, :start_time, :end_time, :priority, :state)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
