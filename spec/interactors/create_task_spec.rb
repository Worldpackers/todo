require 'rails_helper'

describe CreateTask do
  subject(:context) { CreateTask.call(task_params: {"name"=>"teste"}) }

  describe ".call" do
    context "when given valid parameters" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the task name" do
        expect(context.task.name).to eq("teste")
      end
    end

    context "when given invalid parameters" do
      before do
        allow(Task).to receive(:create).and_return(Task.new)
      end

      it "fails" do
        expect(context).to be_a_failure
      end

      it "provides a failure message" do
        expect(context.message).to be_present
      end
    end
  end
end
