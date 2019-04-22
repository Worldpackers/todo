require 'rails_helper'

describe SendNotification do
  subject(:context) { SendNotification.call(user_email: "walterdf@gmail.com", color: "#FF0000", phrase: "Parabéns!") }

  describe ".call" do
    context "when given valid parameters" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the task mailer" do
        expect(context.task_mailer).to be_truthy
      end
    end

    context "when given invalid parameters" do
      before do
        allow(TaskMailer).to receive(:confirmation).with("walterdf@gmail.com", "#FF0000", "Parabéns!").and_return(nil)
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
