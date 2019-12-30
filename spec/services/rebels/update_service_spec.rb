require "rails_helper"

RSpec.describe Rebels::UpdateService, "#run" do

  describe "When updating details" do

    it "has the expected details" do

      details = {
        "availability" => FFaker::Lorem.sentence,
        "interests" => FFaker::Lorem.paragraph(3),
        "internal_notes" => FFaker::Lorem.sentence,
        "irl" => true,

        "name" => FFaker::Name.name,
        "notes" => FFaker::Lorem.paragraph(3),
        "number_of_arrests" => 1,
        "phone" => FFaker::PhoneNumber.phone_number,
        "postcode" => FFaker::AddressFR.postal_code,
        "status" => ['active', 'paused', 'inactive'].sample,
        "tag_list" => FFaker::Lorem.word,
        "willingness_to_be_arrested" => true,
        "regular_volunteer" => true,
      }

      association_ids = {
        "local_group_id" => create(:local_group).id,
        "skill_ids" => create_list(:skill, 2).map(&:id),
        "working_group_ids" => create_list(:working_group, 2).map(&:id),
      }


      params_hash = {
        rebel: details.merge(association_ids)
      }
      params = ActionController::Parameters.new(params_hash)

      subject.run(params)

      rebel = subject.rebel
      expect(rebel).to be_persisted

      # strange behaviour about tag_list : we assign a word but get back an array
      expect(rebel.attributes).to include(details.except("tag_list"))
      expect(rebel.tag_list).to match_array([ details["tag_list"] ])

      association_ids.each do |field, value|
        rebel_associated_id = rebel.public_send(field)
        expect(rebel_associated_id).to eq value
      end

    end

  end

  let!(:rebel){ create(:rebel) }
  subject { described_class.new(rebel: rebel) }
end
