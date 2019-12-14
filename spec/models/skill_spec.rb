require "rails_helper"

RSpec.describe Skill, "validations" do
  let(:skill) { create(:skill) }

  it "is valid with valid attributes" do
    expect(skill).to be_valid
  end

  it "isn't valid if code is missing" do
    skill.code = nil
    skill.valid?
    expect(skill.errors.count).to eq 1
  end
end

RSpec.describe Skill, "on_update" do
  it "can't be updated if code is already used" do
    skill1 = create(:skill, code: "ABC")
    skill2 = create(:skill, code: "QWE")
    skill1.update(code: "QWE")
    expect(skill1.errors.count).to eq 1
  end
end
