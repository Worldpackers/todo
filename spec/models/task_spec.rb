require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Validations" do
    subject { described_class.new(name: "Walter", completed: true) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = 'W'
      expect(subject).to_not be_valid
    end
  end
end
