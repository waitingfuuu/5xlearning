# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_admin_user, only: %i[show edit update destroy]

    def index
      @admin_users = User.all
    end

    def new
      @admin_user = User.new
    end

    def create
      @admin_user = User.new(admin_user_params)

      if @admin_user.save
        flash[:notice] = t('flash.user_successfully_created')

        redirect_to admin_users_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @admin_user.update(admin_user_params)
        flash[:notice] = t('flash.user_successfully_edited')

        redirect_to admin_users_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @admin_user.tasks.destroy_all
      User.destroy(params[:id])

      flash[:notice] = t('flash.user_successfully_deleted')
      redirect_to admin_users_path
    end

    def show; end

    private

    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    def admin_user_params
      params.require(:admin_user).permit(:name, :password)
    end
  end
end
