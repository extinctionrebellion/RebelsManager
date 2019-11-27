require "rails_helper"

RSpec.describe Skills::CreateService, "#run" do
  describe "When code is missing" do
    it "doesn't create the skill" do
      params = ActionController::Parameters.new({
        skill: {
          name: FFaker::Skill.specialty
        }
      })

      service = Skills::CreateService.new
      service.run(params)

      expect(Skill.count).to eq(0)
    end
  end
end
