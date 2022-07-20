# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[update edit]

  def index
    if params[:search] || params[:state_select]
      search
    elsif params[:end_time] || params[:priority] || params[:state]
      order
    else
      @tasks = Task.tagged_with(params[:tag]) if params[:tag]

      @tasks = Task.all
    end
    @tasks = @tasks.order('created_at DESC').paginate(page: params[:page], per_page: 10)
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

  def search
    @tasks = Task.where('title LIKE ?', "%#{params[:search]}%")
    return if params[:state_select].blank?

    @tasks = Task.where(state: params[:state_select])
  end

  def order
    @tasks = if params[:end_time]
               params[:end_time] == 'asc' ? Task.all.order('end_time ASC') : Task.all.order('end_time DESC')
             elsif params[:state]
               params[:state] == 'asc' ? Task.all.order('state ASC') : Task.all.order('state DESC')
             else
               params[:priority] == 'asc' ? Task.all.order('priority ASC') : Task.all.order('priority DESC')
             end
  end
end
