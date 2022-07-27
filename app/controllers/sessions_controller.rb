# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:session][:name])
    if user&.authenticate(params[:session][:password_digest])
      log_in user
      current_user
      redirect_to root_path
    else
      flash.now[:login_error] = t('flash.invalid_username_or_password')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    flash[:notice] = t('flash.you_have_been_logged_out')
    redirect_to root_path
  end

  private

  def user_params
    params.require(:session).permit(:name, :password)
  end
end
