require 'rails_helper'

describe UpdateTask do

  let(:valid_attributes) {
    { name: 'Name Task!' }
  }

  let(:new_attributes) {
    { name: 'New Name Task!', completed: true }
  }

  before do
    @task = Task.create! valid_attributes
  end

  subject(:context) { UpdateTask.call(task_params: new_attributes, task: @task) }

  describe ".call" do
    context "when complete a task" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "check task update" do
        expect(context.task_update).to eq(true)
      end

      it "provides the completed" do
        expect(context.task.completed).to eq(true)
      end

      it "call completed task" do
        expect(context.call_completed_task).to be_truthy
      end
    end
  end
end
