class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]
  skip_before_action :login_required, only: %i[new create]

  def show
    redirect_to user_path(current_user.id) unless @user.id == current_user.id
  end

  def new
    redirect_to tasks_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "ユーザー「#{@user.name}」を登録してログインしました"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
