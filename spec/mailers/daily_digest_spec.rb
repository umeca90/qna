require "rails_helper"

RSpec.describe DailyDigestMailer, type: :mailer do
  describe "digest" do
    let(:user) { create :user}
    let(:mail) { DailyDigestMailer.digest(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("List of questions created yesterday")
      expect(mail.to).to eq(["user1@mail.net"])
      expect(mail.from).to eq(["from@example.com"])
    end
  end

end
