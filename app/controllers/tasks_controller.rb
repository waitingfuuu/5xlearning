# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[update edit]

  def index
    return unless session[:user_id]

    @current_user = User.find(session[:user_id])

    if params[:search] || params[:state_select]
      search
    elsif params[:end_time] || params[:priority] || params[:state]
      order
    else
      @tasks = Task.tagged_with(params[:tag]) if params[:tag]
      @tasks = @current_user.tasks
    end
    @tasks = @tasks.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

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
    params.require(:task).permit(:title, :content, :tag,
                                 :build_time, :start_time, :end_time, :priority, :state)
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def search
    @tasks = @current_user.tasks.where('title LIKE ?', "%#{params[:search]}%")
    return if params[:state_select].blank?

    @tasks = Task.where(state: params[:state_select])
  end

  def order
    @tasks = Task.tagged_with(params[:tag]) if params[:tag]
    @tasks = @current_user.tasks
    @tasks = if params[:end_time]
               params[:end_time] == 'asc' ? @tasks.order('end_time ASC') : @tasks.order('end_time DESC')
             elsif params[:state]
               params[:state] == 'asc' ? @tasks.order('state ASC') : @tasks.order('state DESC')
             else
               params[:priority] == 'asc' ? @tasks.order('priority ASC') : @tasks.order('priority DESC')
             end
  end
end
