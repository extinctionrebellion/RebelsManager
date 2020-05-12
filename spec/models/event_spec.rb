# == Schema Information
#
# Table name: events
#
#  id             :bigint           not null, primary key
#  description    :text
#  ends_at        :datetime
#  facebook_url   :string
#  name           :string
#  slug           :string
#  starts_at      :datetime
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
