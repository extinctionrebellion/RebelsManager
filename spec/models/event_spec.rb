# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  description    :text
#  ends_at        :string
#  facebook_url   :string
#  name           :string
#  starts_at      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  local_group_id :bigint
#

require "rails_helper"

RSpec.describe Event, "validations" do
  let(:event) { create(:event) }

  it "is valid with valid attributes" do
    expect(event).to be_valid
  end
end
