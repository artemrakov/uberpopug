class TasksController < ApplicationController
  before_action :authenticate_account!

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    employee = Account.employee.sample
    @task.employee = employee

    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def shuffle
  end

  def complete
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
