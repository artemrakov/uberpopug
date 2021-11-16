class TasksController < ApplicationController
  before_action :authenticate_account!

  def index
    @tasks = Task.includes(:employee)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    employee = Account.employee.sample
    @task.employee = employee

    if @task.save
      created_event = {
        event_name: 'TaskCreated',
        data: {
          description: @task.description,
          public_id: @task.public_id,
          status: @task.status,
          employee_public_id: @task.employee.public_id
        }
      }
      WaterDrop::SyncProducer.call(created_event.to_json, topic: 'tasks-stream')

      assigned_event = {
        event_name: 'TaskAssigned',
        data: {
          public_id: @task.public_id,
          employee_public_id: @task.employee.public_id
        }
      }
      WaterDrop::SyncProducer.call(assigned_event.to_json, topic: 'tasks')

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
      event_name: 'TaskCompleted',
      data: {
        public_id: task.public_id
      }
    }
    WaterDrop::SyncProducer.call(event.to_json, topic: 'tasks-lifecycle')

    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end
end
