class TasksController < ApplicationController
  respond_to :json

  def index
    respond_with Task.all
  end

  def show
    respond_with Task.find(params[:id])
  end

  def create
    task = Task.create task_params
    respond_with task
  end

  def update
    task = Task.find(params[:id])
    task.update task_params
    respond_with task
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    respond_with task
  end

private
  def task_params
    params.require(:task).permit(:title)
  end
end
