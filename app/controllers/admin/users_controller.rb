class Admin::UsersController < ApplicationController
  before_action :set_params, only: %i[show edit update destroy]
  before_action :admin_login_required

  def index
    @users =
      if params[:sort_created_at]
        User.order(created_at: :desc).includes(:tasks).page(params[:page])
      else
        User.order(:id).includes(:tasks).page(params[:page])
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
    if @user == current_user && user_params[:admin] == '0'
      redirect_to edit_admin_user_path(@user), notice: '自分の管理者権限は変更できません'
    elsif @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を編集しました"
    else
      render :edit
    end
  end

  def destroy
    if User.where(admin: true).size >= 2 && @user == current_user
      redirect_to admin_users_path, notice: '自分自身は削除できません'
    elsif @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
    else
      redirect_to admin_users_path, notice: '管理者がいなくなるため削除できません'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :admin
    )
  end

  def set_params
    @user = User.find(params[:id])
  end

  def admin_login_required
    raise Forbidden unless current_user.admin?
  end
end
