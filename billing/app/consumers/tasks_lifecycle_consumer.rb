class TasksLifecycleConsumer < ApplicationConsumer
  def consume
    params_batch.payloads.each do |payload|
      puts '-' * 80
      p payload
      puts '-' * 80

      data = payload['data']

      case payload['event_name']
      when 'TaskAssigned'
        ActiveRecord::Base.transaction do
          cost = (10..20).to_a.sample * 100

          task = Task.find_by!(public_id: data['public_id'])
          task.update!(cost: cost)

          account = Account.find_by!(public_id: data['employee_public_id'])
          billing_cycle = BillingCycle.find_or_create_by!(status: :in_process, account: account)

          balance = account.balance - cost
          account.update!(balance: balance)

          Transaction::Charge.create!(
            accounting_entry: 'credit',
            amount: cost,
            billing_cycle: billing_cycle,
            account: account,
            data: {
              task_public_id: task.public_id,
              task_id: task.id,
              description: "Task Assigned ##{task.public_id} to #{account.email}"
            }
          )
        end
      when 'TaskReassigned'
        ActiveRecord::Base.transaction do
          task = Task.find_by!(public_id: data['public_id'])
          account = Account.find_by!(public_id: data['employee_public_id'])
          billing_cycle = BillingCycle.find_or_create_by!(status: :in_process, account: account)

          balance = account.balance - task.cost
          account.update!(balance: balance)

          Transaction::Charge.create!(
            accounting_entry: 'credit',
            amount: task.cost,
            billing_cycle: billing_cycle,
            account: account,
            data: {
              task_public_id: task.public_id,
              task_id: task.id,
              description: "Task Reassigned ##{task.public_id} to #{account.email}"
            }
          )
        end
      when 'TaskCompleted'
        ActiveRecord::Base.transaction do
          task = Task.find_by!(public_id: data['public_id'])
          account = Account.find_by!(public_id: data['employee_public_id'])
          billing_cycle = BillingCycle.find_or_create_by!(status: :in_process, account: account)

          reward = (20..40).to_a.sample * 100
          balance = account.balance + reward
          account.update!(balance: balance)

          Transaction::Payout.create!(
            accounting_entry: 'debit',
            amount: reward,
            billing_cycle: billing_cycle,
            account: account,
            data: {
              task_public_id: task.public_id,
              task_id: task.id,
              description: "Task Completed ##{task.public_id} by #{account.email}"
            }
          )
        end
      else
        # store in db
      end
    end
  end
end
