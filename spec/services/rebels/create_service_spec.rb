require "rails_helper"

RSpec.describe Rebels::CreateService, "#run" do
  describe "When email format is not valid" do
    it "doesn't create the rebel" do
      base_params_hash = valid_params.to_unsafe_hash
      invalid_params_hash = base_params_hash.deep_merge(rebel: {
        email: "badly_formatted_email@provider",
      })
      invalid_params = ActionController::Parameters.new(invalid_params_hash)

      service = Rebels::CreateService.new(source: "admin")

      expect {
        service.run(invalid_params)
      }.not_to change{ Rebel.count }
    end
  end

  describe "When the rebel has been created" do

    it "has the expected details" do
      core = valid_params.to_unsafe_h

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

      params_hash = core
                      .deep_merge(rebel: details)
                      .deep_merge(rebel: association_ids)

      params = ActionController::Parameters.new(params_hash)
      service = Rebels::CreateService.new(source: "admin")
      service.run(params)

      rebel = service.rebel
      expect(rebel).to be_persisted

      # strange behaviour about tag_list : we assign a word but get back an array
      expect(rebel.attributes).to include(details.except("tag_list"))
      expect(rebel.tag_list).to match_array([ details["tag_list"] ])

      association_ids.each do |field, value|
        rebel_associated_id = rebel.public_send(field)
        expect(rebel_associated_id).to eq value
      end

    end

    it "has a token" do
      service = Rebels::CreateService.new(source: "admin")
      service.run(valid_params)

      rebel = service.rebel
      expect(rebel).to be_persisted
      expect(rebel.token).to be_truthy
    end

  end

  subject { Rebels::CreateService.new(source: "admin") }

  let(:valid_params) do
    ActionController::Parameters.new(
      {
        "rebel" => {
          "email" => FFaker::Internet.safe_email,
          "language" => "en"
        }
      }
    )
  end
end
