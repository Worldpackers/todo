class TasksController < ApplicationController
  before_action :set_task, only: [:update, :edit, :destroy]

  def index
    @tasks = Task.all.order(:created_at)
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    result = CreateTask.call(task_params: task_params)

    respond_to do |format|
      if result.success?
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { redirect_to new_task_url, notice: 'Error creating task.' }
        format.json { render json: result.message, status: :unprocessable_entity }
      end
    end
  end

  def update
    result = UpdateTask.call(task_params: task_params, task: @task)

    respond_to do |format|
      if result.success?
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { redirect_to edit_task_path, notice: 'Error editing.' }
        format.json { render json: result.message, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :completed)
    end
end
