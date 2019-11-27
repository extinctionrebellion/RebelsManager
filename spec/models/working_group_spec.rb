require "rails_helper"

RSpec.describe WorkingGroup, "validations" do
  let(:working_group) { create(:working_group) }

  it "is valid with valid attributes" do
    expect(working_group).to be_valid
  end

  it "isn't valid if code is missing" do
    working_group.code = nil
    working_group.valid?
    expect(working_group.errors.count).to eq 1
  end
end

RSpec.describe WorkingGroup, "on_update" do
  it "can't be updated if code is already used at the local group level" do
    local_group = create(:local_group)
    working_group1 = create(:working_group, local_group: local_group, code: "ABC")
    working_group2 = create(:working_group, local_group: local_group, code: "QWE")
    working_group1.update(code: "QWE")
    expect(working_group1.errors.count).to eq 1
  end
end
