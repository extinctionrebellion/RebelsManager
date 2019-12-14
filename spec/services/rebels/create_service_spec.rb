require "rails_helper"

RSpec.describe Rebels::CreateService, "#run" do
  describe "When email format is not valid" do
    it "doesn't create the rebel" do
      params = ActionController::Parameters.new({
        rebel: {
          email: "badly_formatted_email@provider",
          language: "en"
        }
      })

      service = Rebels::CreateService.new(source: "admin")
      service.run(params)

      expect(Rebel.count).to eq(0)
    end
  end

  describe "When the rebel has been created" do
    it "has a token" do
      params = ActionController::Parameters.new({
        rebel: {
          email: FFaker::Internet.safe_email,
          language: "en"
        }
      })

      service = Rebels::CreateService.new(source: "admin")
      service.run(params)

      rebel = Rebel.first
      expect(rebel.token).to be_truthy
    end
  end
end
