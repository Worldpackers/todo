class UpdateTask
  include Interactor

  def call
    if task = context.task.update(context.task_params)
      context.task_update = task
    else
      context.fail!(message: "Could not update task!")
    end
  end

  after do
    if context.task_update && context.task.completed
      context.call_completed_task = CompletedTask.call
    end
  end
end
