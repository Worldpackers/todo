require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  describe "confirmation" do
    let(:mail) { TaskMailer.confirmation("teste@gmail.com", "#FF0000", "Parabéns!") }

    it "renders the headers" do
      expect(mail.subject).to eq("App Rails de To Do - Task")
      expect(mail.to).to eq(["teste@gmail.com"])
      expect(mail.from).to eq([ENV['SMTP_USER_NAME']])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Parabéns!")
    end
  end
end
