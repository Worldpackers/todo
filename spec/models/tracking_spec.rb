require 'rails_helper'

RSpec.describe Tracking, type: :model do
  describe "Validations" do
    subject { described_class.new(type_tracking: "task", json: "{\"user\":\"walterdf@gmail.com\",\"color\":\"#F3947E\",\"phrase\":\"Parabéns!\"}" ) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a json" do
      subject.json = nil
      expect(subject).to_not be_valid
    end
  end
end
