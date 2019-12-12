class Admin::UsersController < ApplicationController
  before_action :set_params, only: %i[show edit update destroy]

  def index
    @users =
      if params[:sort_created_at]
        User.order(created_at: :desc).page(params[:page])
      else
        @users = User.all.page(params[:page])
      end
  end

  def show
    @user_tasks = @user.tasks.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_params
    @user = User.find(params[:id])
  end
end
