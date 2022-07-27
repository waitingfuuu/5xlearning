# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.password_digest = BCrypt::Password.create(user_params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: t('flash.signup_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
