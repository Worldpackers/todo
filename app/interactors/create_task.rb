class CreateTask
  include Interactor

  def call
    task = Task.create(context.task_params)

    if task.valid?
      context.task = task
    else
      context.fail!(message: "Could not create task!")
    end
  end
end
