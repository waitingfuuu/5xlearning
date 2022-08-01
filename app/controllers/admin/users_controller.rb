# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[tasks edit update destroy]

    def index
      unless session[:user_id]
        redirect_to root_path
        return
      end

      @current_user ||= User.find(session[:user_id])
      unless @current_user.admin == 'admin'
        flash[:notice] = t('flash.user_not_admin')

        redirect_to root_path
        return
      end

      @users = User.all.order('id')
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = t('flash.user_successfully_created')

        redirect_to admin_users_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:notice] = t('flash.user_successfully_edited')

        redirect_to admin_users_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @user.admin == 'admin' && User.where(admin: 'admin').count == 1
        flash[:notice] = I18n.t('flash.admin_can_not_be_empty')
      else
        @user.tasks.destroy_all
        @user.destroy

        if @user.id == session[:user_id]
          session.delete(:user_id)
          redirect_to root_path
          return
        end
        flash[:notice] = t('flash.user_successfully_deleted')
      end
      redirect_to admin_users_path
    end

    def tasks; end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :admin, :password)
    end
  end
end
