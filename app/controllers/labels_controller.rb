class LabelsController < ApplicationController
  before_action :set_params, only: %i[show edit update destroy]
  def index
    @labels = current_user.labels.order(created_at: :desc)
  end

  def show
  end

  def new
    @label = Label.new
    @lebels = current_user.labels
  end

  def create
    @label = Label.new(label_params)

    if @label.save
      redirect_to labels_path, notice: "ラベル「#{@label.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: "ラベル「#{@label.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: "ラベル「#{@label.name}」を削除しました"
  end

  private

  def label_params
    params.require(:label).permit(:name, :user_id)
  end

  def set_params
    @label = Label.find(params[:id])
  end
end
