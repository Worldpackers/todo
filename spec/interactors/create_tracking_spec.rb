require 'rails_helper'

describe CreateTracking do
  subject(:context) { CreateTracking.call }

  describe ".call" do
    context "when given valid parameters" do
      it "succeeds" do
        expect(context).to be_a_success
      end

      it "create_tracking" do
        expect(context.create_tracking).to be_truthy
      end
    end

    context "when given invalid parameters" do
      before do
        allow(Tracking).to receive(:create).and_return(Tracking.new)
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
