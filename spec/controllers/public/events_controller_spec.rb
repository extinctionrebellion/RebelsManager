require "rails_helper"

RSpec.describe Public::EventsController, "#index" do
  describe "when listing upcoming events" do
    describe "if there are upcoming events" do
      it "loads the event" do
        event = create(:event, :upcoming)
        event2 = create(:event, :upcoming)
        get :index
        expected = [event, event2].sort_by(&:starts_at)
        expect(events).to be_a ActiveRecord::Relation
        expect(events.to_a).to eq expected
      end
    end
  end

  describe "when listing past events" do
    describe "if there is a past event" do
      it "loads the event" do
        event = create(:event, :past)
        event2 = create(:event, :past)
        get :index, params: { scope: "past" }
        expected = [event, event2].sort_by(&:ends_at)
        expect(events).to be_a ActiveRecord::Relation
        expect(events.to_a).to eq expected
      end
    end
  end
end
