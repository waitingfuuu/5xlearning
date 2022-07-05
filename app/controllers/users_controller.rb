
class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    format.html { redirect_to user_url(@user), notice: "User was successfully created." }
    format.html { render :new, status: :unprocessable_entity }
  end

  def update
    format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
    format.html { render :edit, status: :unprocessable_entity }
  end

  def destroy
    @user.destroy
    format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:_id, :username, :pw, :admin)
    end
end
