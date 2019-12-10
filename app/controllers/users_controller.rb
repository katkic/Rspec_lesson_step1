class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
