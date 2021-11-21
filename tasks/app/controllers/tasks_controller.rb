class TasksController < ApplicationController
  before_action :authenticate_account!

  def index
    @tasks = Task.includes(:employee)
  end

  def new
    @task = Task.new
  end

  def create
    @task = TaskMutator.create(task_params)

    if @task.save
      redirect_to root_path
    else
      render :new
    end
  end

  def reassign
    tasks = Task.in_progress
    employees = Account.employee

    TaskService.reassign(tasks, employees)
    redirect_to root_path
  end

  def complete
    task = Task.find(params[:id])
    task.complete!

    event = {
      event_id: SecureRandom.uuid,
      event_version: 1,
      event_time: Time.zone.now.to_s,
      producer: 'task_service',
      event_name: 'TaskCompleted',
      data: {
        public_id: task.public_id
      }
    }
    EventSender.serve!(event: event, type: 'tasks.completed', topic: 'tasks-lifecycle')

    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
