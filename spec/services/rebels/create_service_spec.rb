require "rails_helper"

RSpec.describe Rebels::CreateService, "#run" do
  describe "When email format is not valid" do
    params = {
      rebel: {
        email: "badly_formatted_email@provider",
        language: "en"
      }
    }

    service = Rebels::CreateService.new(source: "admin")
    service.run(params)

    expect(service.error_message).to eq("Please double check the email address provided.")
  end
end
