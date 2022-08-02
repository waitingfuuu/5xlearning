# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[tasks edit update destroy]

    def index
      redirect_to root_path unless session[:user_id]

      @current_user ||= User.find(session[:user_id])
      unless @current_user.role == 'admin'
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
      if @user.destroy
        if @user.id == session[:user_id]
          session.delete(:user_id)
          redirect_to root_path
          return
        end
        flash[:notice] = t('flash.user_successfully_deleted')
      else
        flash[:notice] = @user.errors.full_messages[0]
      end
      redirect_to admin_users_path
    end

    def tasks; end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :role, :password)
    end
  end
end
