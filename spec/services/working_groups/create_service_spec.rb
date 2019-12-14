require "rails_helper"

RSpec.describe WorkingGroups::CreateService, "#run" do
  describe "When code is missing" do
    it "doesn't create the working group" do
      local_group = create(:local_group)

      params = ActionController::Parameters.new({
        working_group: {
          local_group_id: local_group.id,
          name: "Regenerative Culture"
        }
      })

      service = WorkingGroups::CreateService.new
      service.run(params)

      expect(WorkingGroup.count).to eq(0)
    end
  end
end
