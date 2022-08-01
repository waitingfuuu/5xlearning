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
			if @user.destroy
				session.delete(:user_id) if @user == User.find(session[:user_id])

				@user.tasks.destroy_all
				User.destroy(params[:id])
				flash[:notice] = t('flash.user_successfully_deleted')
				redirect_to admin_users_path
			else
				flash[:notice] = @user.errors[:base][0]
				redirect_to admin_users_path
			end
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
