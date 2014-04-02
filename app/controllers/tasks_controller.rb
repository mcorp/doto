class TasksController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.tasks
  end

  def show
    respond_with current_user.tasks.find(params[:id])
  end

  def create
    task = current_user.tasks.create task_params
    respond_with task
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update task_params
    respond_with task
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    respond_with task
  end

private
  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
