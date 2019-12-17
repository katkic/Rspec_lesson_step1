class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    tasks = current_user.tasks
    @tasks =
      if params[:sort_expired]
        tasks.order(:expired_at).page(params[:page])
      elsif params[:sort_priority]
        tasks.order(priority: :desc).page(params[:page])
      elsif params[:sort_created_at]
        tasks.order(created_at: :desc).page(params[:page])
      else
        tasks.order(created_at: :desc).page(params[:page])
      end
  end

  def show
  end

  def new
    @task = Task.new
    3.times { @task.labels.build }
  end

  def edit
    @task.labels.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました"
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "タスク「#{@task.name}」を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスク「#{@task.name}」を削除しました"
  end

  def search
    @search_params = task_search_params
    @search_params[:user_id] = current_user.id
    @tasks = Task.search(@search_params).page(params[:page])
    render :index
  end

  private

  def task_params
    params.require(:task).permit(
      :name,
      :description,
      :expired_at,
      :status,
      :priority,
      label_ids: [],
      labels_attributes: %i[name user_id]
    )
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_search_params
    params.fetch(:search, {}).permit(:name, :status, :expired_at, :priority, :label_id)
  end
end
