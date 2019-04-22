require 'rails_helper'

describe CompletedTask do
  subject(:context) { CompletedTask.call }

  describe ".call" do
    it "succeeds" do
      expect(context).to be_a_success
    end
  end
end
